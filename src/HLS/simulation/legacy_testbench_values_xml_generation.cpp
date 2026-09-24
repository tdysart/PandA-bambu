/*
 *
 *                   _/_/_/    _/_/   _/    _/ _/_/_/    _/_/
 *                  _/   _/ _/    _/ _/_/  _/ _/   _/ _/    _/
 *                 _/_/_/  _/_/_/_/ _/  _/_/ _/   _/ _/_/_/_/
 *                _/      _/    _/ _/    _/ _/   _/ _/    _/
 *               _/      _/    _/ _/    _/ _/_/_/  _/    _/
 *
 *             ***********************************************
 *                              PandA Project
 *                     URL: http://panda.dei.polimi.it
 *                       Politecnico di Milano - DEIB
 *                        System Architectures Group
 *             ***********************************************
 *              Copyright (C) 2004-2024 Politecnico di Milano
 *
 *   This file is part of the PandA framework.
 *
 *   The PandA framework is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
/**
 * @file legacy_testbench_values_xml_generation.cpp
 * @brief Write the stimulus/expected-values file (simulation/values.txt) of the legacy testbench from the XML
 * test vectors.
 *
 * Ported from bambu 2023.1 (src/HLS/simulation/testbench_values_xml_generation.cpp).
 */
#include "legacy_testbench_values_xml_generation.hpp"

#include "Parameter.hpp"
#include "SimulationInformation.hpp"
#include "behavioral_helper.hpp"
#include "c_initialization_parser.hpp"
#include "custom_map.hpp"
#include "dbgPrintHelper.hpp"
#include "function_behavior.hpp"
#include "hls_manager.hpp"
#include "legacy_testbench_utils.hpp"
#include "memory.hpp"
#include "memory_initialization_writer.hpp"
#include "string_manipulation.hpp"
#include "testbench_generation.hpp"
#include "tree_helper.hpp"
#include "tree_manager.hpp"
#include "tree_node.hpp"
#include "utility.hpp"

#include <algorithm>
#include <fstream>
#include <list>
#include <string>
#include <tuple>
#include <vector>

LegacyTestbenchValuesXMLGeneration::LegacyTestbenchValuesXMLGeneration(
    const ParameterConstRef _parameters, const HLS_managerRef _hls_manager,
    const DesignFlowManagerConstRef _design_flow_manager)
    : HLS_step(_parameters, _hls_manager, _design_flow_manager,
               HLSFlowStep_Type::LEGACY_TESTBENCH_VALUES_XML_GENERATION),
      TM(_hls_manager->get_tree_manager()),
      output_directory(parameters->getOption<std::filesystem::path>(OPT_output_directory) / "simulation")
{
   debug_level = parameters->get_class_debug_level(GET_CLASS(*this));
}

HLS_step::HLSRelationships
LegacyTestbenchValuesXMLGeneration::ComputeHLSRelationships(
    const DesignFlowStep::RelationshipType relationship_type) const
{
   HLSRelationships ret;
   switch(relationship_type)
   {
      case DEPENDENCE_RELATIONSHIP:
      {
         ret.insert(std::make_tuple(HLSFlowStep_Type::TEST_VECTOR_PARSER, HLSFlowStepSpecializationConstRef(),
                                    HLSFlowStep_Relationship::TOP_FUNCTION));
         /// param_mem_size/param_next_off/param_address are computed there
         ret.insert(std::make_tuple(HLSFlowStep_Type::LEGACY_TESTBENCH_MEMORY_ALLOCATION,
                                    HLSFlowStepSpecializationConstRef(), HLSFlowStep_Relationship::TOP_FUNCTION));
         break;
      }
      case INVALIDATION_RELATIONSHIP:
      {
         break;
      }
      case PRECEDENCE_RELATIONSHIP:
      {
         break;
      }
      default:
         THROW_UNREACHABLE("");
   }
   return ret;
}

bool LegacyTestbenchValuesXMLGeneration::HasToBeExecuted() const
{
   return true;
}

DesignFlowStep_Status LegacyTestbenchValuesXMLGeneration::Exec()
{
   const auto top_symbols = parameters->getOption<std::vector<std::string>>(OPT_top_functions_names);
   THROW_ASSERT(top_symbols.size() == 1, "Expected single top function name");
   const auto fnode = TM->GetFunction(top_symbols.front());
   const auto function_id = fnode->index;
   const auto behavioral_helper = HLSMgr->CGetFunctionBehavior(function_id)->CGetBehavioralHelper();
   if(!HLSMgr->RSim->results_available)
   {
      THROW_ERROR("The legacy testbench needs expected outputs in the XML test vectors (param:output, "
                  "param:init_output_file or return attributes); computing them by executing the C "
                  "specification is not supported yet");
   }
   std::filesystem::create_directories(output_directory);
   const auto output_file_name = output_directory / (STR_CST_legacy_testbench_values_basename ".txt");
   std::ofstream output_stream(output_file_name, std::ios::out);
   CInitializationParserRef c_initialization_parser = CInitializationParserRef(new CInitializationParser(parameters));

   /// print base address
   unsigned long long int base_address = HLSMgr->base_address;
   output_stream << "//base address " + STR(base_address) << std::endl;
   std::string trimmed_value;
   for(unsigned int ind = 0; ind < 32; ind++)
   {
      trimmed_value = trimmed_value + (((1LLU << (31 - ind)) & base_address) ? '1' : '0');
   }
   output_stream << "b" + trimmed_value << std::endl;

   const auto mem_vars = HLSMgr->Rmem->get_ext_memory_variables();
   // get the mapping between variables in external memory and their external base address
   std::map<unsigned long long int, unsigned int> address;
   for(const auto& m : mem_vars)
   {
      address[HLSMgr->Rmem->get_external_base_address(m.first)] = m.first;
   }

   /// This is the list of memory variables and of pointer parameters
   std::list<unsigned int> mem;
   for(const auto& ma : address)
   {
      mem.push_back(ma.second);
   }

   const auto fname = tree_helper::GetMangledFunctionName(GetPointerS<const function_decl>(fnode));
   const auto func_arch = HLSMgr->module_arch ? HLSMgr->module_arch->GetArchitecture(fname) : nullptr;
   /// Fixed-point (ac_fixed) interface type of a parameter, or an empty string
   const auto fixed_typename = [&](const std::string& param) -> std::string {
      if(func_arch && func_arch->parms.count(param) &&
         func_arch->parms.at(param).count(FunctionArchitecture::parm_typename))
      {
         const auto argTypename = func_arch->parms.at(param).at(FunctionArchitecture::parm_typename) + " ";
         if(argTypename.find("fixed") != std::string::npos)
         {
            return argTypename;
         }
      }
      return "";
   };

   HLSMgr->RSim->simulationArgSignature.clear();
   const auto& function_parameters = behavioral_helper->GetParameters();
   for(const auto& function_parameter : function_parameters)
   {
      const auto function_parameter_name = behavioral_helper->PrintVariable(function_parameter->index);
      HLSMgr->RSim->simulationArgSignature.push_back(function_parameter_name);
      // if the function has some pointer parameters some memory needs to be reserved for the place where they
      // point to
      if(tree_helper::IsPointerType(function_parameter) && mem_vars.find(function_parameter->index) == mem_vars.end())
      {
         mem.push_back(function_parameter->index);
      }
   }
   unsigned int v_idx = 0;

   INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Writing initialization of memory variables");

   // For each test vector, for each pointer parameter, the space to be reserved in memory
   CustomMap<unsigned int, CustomMap<unsigned int, size_t>> all_reserved_mem_bytes;
   // loop on the test vectors
   for(const auto& curr_test_vector : HLSMgr->RSim->test_vectors)
   {
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Considering new test vector");
      // loop on the variables in memory
      for(const auto& l : mem)
      {
         std::string param = behavioral_helper->PrintVariable(l);
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Considering parameter '" + param + "'");
         const auto is_interface =
             std::find_if(function_parameters.begin(), function_parameters.end(),
                          [&](const tree_nodeRef& tn) { return tn->index == l; }) != function_parameters.end();
         const auto argTypename = is_interface ? fixed_typename(param) : std::string();
         if(param[0] == '"')
         {
            param = "@" + STR(l);
         }

         bool is_memory = false;
         std::string test_v = "0";

         /// Initialization of memory variables which are not pointer parameters
         if(mem_vars.find(l) != mem_vars.end() && !is_interface)
         {
            is_memory = true;
            test_v = LegacyPrintVarInit(TM, l, HLSMgr->Rmem);
         }
         /// Parameter: read initialization from parsed xml
         else if(curr_test_vector.find(param) != curr_test_vector.end())
         {
            test_v = curr_test_vector.find(param)->second;
            if(!argTypename.empty())
            {
               test_v = FixedPointReinterpret(test_v, argTypename);
            }
         }

         /// Retrieve the space to be reserved in memory
         const auto reserved_mem_bytes = [&]() -> size_t {
            if(is_memory)
            {
               return tree_helper::SizeAlloc(TM->GetTreeNode(l)) / 8;
            }
            THROW_ASSERT(HLSMgr->RSim->param_mem_size.count(v_idx), "");
            THROW_ASSERT(HLSMgr->RSim->param_mem_size.at(v_idx).count(l), "");
            return HLSMgr->RSim->param_mem_size.at(v_idx).at(l);
         }();

         all_reserved_mem_bytes[v_idx][l] = reserved_mem_bytes;

         if(is_memory)
         {
            const auto splitted = string_to_container<std::vector<std::string>>(test_v, ",");
            for(const auto& element : splitted)
            {
               THROW_ASSERT(element.size() % 8 == 0, element + ": " + STR(element.size()));
               for(size_t bits = 0; bits < element.size(); bits += 8)
               {
                  output_stream << "m" << element.substr(element.size() - 8 - bits, 8);
               }
            }
         }
         else
         {
            /// Call the parser to translate C initialization to Verilog initialization
            const CInitializationParserFunctorRef c_initialization_parser_functor =
                CInitializationParserFunctorRef(new MemoryInitializationWriter(
                    output_stream, TM, behavioral_helper, reserved_mem_bytes, TM->GetTreeNode(l),
                    TestbenchGeneration_MemoryType::MEMORY_INITIALIZATION, parameters));
            INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                           "---Parsing initialization of " + param + "(" +
                               tree_helper::CGetType(TM->GetTreeNode(l))->get_kind_text() + "): " + test_v);
            c_initialization_parser->Parse(c_initialization_parser_functor, test_v);
         }
         const size_t next_object_offset = HLSMgr->RSim->param_next_off.at(v_idx).at(l);

         if(next_object_offset > reserved_mem_bytes)
         {
            for(unsigned int padding = 0; padding < next_object_offset - reserved_mem_bytes; padding++)
            {
               output_stream << "m00000000" << std::endl;
            }
         }
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered parameter '" + param + "'");
      }
      ++v_idx;
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered vector");
   }
   INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Written initialization of memory variables");
   INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Writing values of parameters");
   v_idx = 0;
   for(const auto& curr_test_vector : HLSMgr->RSim->test_vectors)
   {
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Writing initialization of parameters");
      for(const auto& function_parameter : function_parameters)
      {
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Considering parameter " + STR(function_parameter));
         const auto param = behavioral_helper->PrintVariable(function_parameter->index);
         if(tree_helper::IsPointerType(function_parameter))
         {
            const auto memory_addr = STR(HLSMgr->RSim->param_address.at(v_idx).at(function_parameter->index));
            output_stream << "//parameter: " + param << " value: " << memory_addr << std::endl;
            output_stream << "p" << ConvertInBinary(memory_addr, 32, false, false) << std::endl;
         }
         else
         {
            const CInitializationParserFunctorRef c_initialization_parser_functor(new MemoryInitializationWriter(
                output_stream, TM, behavioral_helper, tree_helper::SizeAlloc(function_parameter) / 8,
                function_parameter, TestbenchGeneration_MemoryType::INPUT_PARAMETER, parameters));
            c_initialization_parser->Parse(c_initialization_parser_functor, curr_test_vector.at(param));
         }
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered parameter " + STR(function_parameter));
      }
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                     "-->Writing expected content of pointer parameters at the end of the execution");
      for(const auto& function_parameter : function_parameters)
      {
         if(tree_helper::IsPointerType(function_parameter))
         {
            INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                           "-->Considering parameter " + STR(function_parameter));
            const auto param = behavioral_helper->PrintVariable(function_parameter->index);
            /// Without an explicit expected output, the pointed memory is expected to be unchanged
            const auto expected_values = [&]() -> std::string {
               const auto ctv = curr_test_vector.count(param + ":output") ? curr_test_vector.at(param + ":output") :
                                                                            curr_test_vector.at(param);
               const auto argTypename = fixed_typename(param);
               return argTypename.empty() ? ctv : FixedPointReinterpret(ctv, argTypename);
            }();
            const CInitializationParserFunctorRef c_initialization_parser_functor(new MemoryInitializationWriter(
                output_stream, TM, behavioral_helper, all_reserved_mem_bytes.at(v_idx).at(function_parameter->index),
                function_parameter, TestbenchGeneration_MemoryType::OUTPUT_PARAMETER, parameters));
            INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                           "---Parsing expected output for " + param + ": " + expected_values);
            c_initialization_parser->Parse(c_initialization_parser_functor, expected_values);
            output_stream << "e" << std::endl;
            INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                           "<--Considered parameter " + STR(function_parameter));
         }
      }
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                     "<--Written expected content of pointer parameters at the end of the execution");
      const auto return_type = tree_helper::GetFunctionReturnType(fnode);
      if(return_type)
      {
         if(!curr_test_vector.count("return"))
         {
            THROW_ERROR("Missing expected return value (return attribute) in test vector " + STR(v_idx));
         }
         const CInitializationParserFunctorRef c_initialization_parser_functor(new MemoryInitializationWriter(
             output_stream, TM, behavioral_helper, tree_helper::SizeAlloc(return_type) / 8, return_type,
             TestbenchGeneration_MemoryType::RETURN, parameters));
         c_initialization_parser->Parse(c_initialization_parser_functor, curr_test_vector.at("return"));
      }
      ++v_idx;
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered vector");
   }
   INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Written values of parameters");
   output_stream << "e" << std::endl;
   output_stream.close();
   return DesignFlowStep_Status::SUCCESS;
}
