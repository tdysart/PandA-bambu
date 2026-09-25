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
 * @file verilog_testbench_memory_allocation.cpp
 * @brief Reserve memory for the pointer arguments of the top function in the self-contained Verilog (XML) testbench.
 *
 * Ported from bambu 2023.1 (src/HLS/simulation/testbench_memory_allocation.cpp).
 */
#include "verilog_testbench_memory_allocation.hpp"

#include "Parameter.hpp"
#include "SimulationInformation.hpp"
#include "behavioral_helper.hpp"
#include "c_initialization_parser.hpp"
#include "c_initialization_parser_functor.hpp"
#include "compute_reserved_memory.hpp"
#include "dbgPrintHelper.hpp"
#include "function_behavior.hpp"
#include "hls_manager.hpp"
#include "math_function.hpp"
#include "memory.hpp"
#include "string_manipulation.hpp"
#include "tree_helper.hpp"
#include "tree_manager.hpp"
#include "tree_node.hpp"
#include "utility.hpp"
#include "verilog_testbench_utils.hpp"

#include <algorithm>
#include <filesystem>
#include <fstream>
#include <list>
#include <string>
#include <tuple>
#include <vector>

VerilogTestbenchMemoryAllocation::VerilogTestbenchMemoryAllocation(const ParameterConstRef _parameters,
                                                                   const HLS_managerRef _HLSMgr,
                                                                   const DesignFlowManagerConstRef _design_flow_manager)
    : HLS_step(_parameters, _HLSMgr, _design_flow_manager, HLSFlowStep_Type::VERILOG_TESTBENCH_MEMORY_ALLOCATION)
{
   debug_level = parameters->get_class_debug_level(GET_CLASS(*this));
}

HLS_step::HLSRelationships VerilogTestbenchMemoryAllocation::ComputeHLSRelationships(
    const DesignFlowStep::RelationshipType relationship_type) const
{
   HLSRelationships ret;
   switch(relationship_type)
   {
      case DEPENDENCE_RELATIONSHIP:
      {
         ret.insert(std::make_tuple(HLSFlowStep_Type::TEST_VECTOR_PARSER, HLSFlowStepSpecializationConstRef(),
                                    HLSFlowStep_Relationship::TOP_FUNCTION));
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

bool VerilogTestbenchMemoryAllocation::HasToBeExecuted() const
{
   return true;
}

DesignFlowStep_Status VerilogTestbenchMemoryAllocation::Exec()
{
   const auto TM = HLSMgr->get_tree_manager();
   const auto flag_cpp =
       TM->is_CPP() && !parameters->isOption(OPT_pretty_print) &&
       (!parameters->isOption(OPT_discrepancy) || !parameters->getOption<bool>(OPT_discrepancy) ||
        !parameters->isOption(OPT_discrepancy_hw) || !parameters->getOption<bool>(OPT_discrepancy_hw));
   const auto top_symbols = parameters->getOption<std::vector<std::string>>(OPT_top_functions_names);
   THROW_ASSERT(top_symbols.size() == 1, "Expected single top function name");
   const auto top_fnode = TM->GetFunction(top_symbols.front());
   const auto function_id = top_fnode->index;
   const auto BH = HLSMgr->CGetFunctionBehavior(function_id)->CGetBehavioralHelper();
   const auto get_param_name = [&](const unsigned int p)
   {
      const auto param = BH->PrintVariable(p);
      if(param.front() == '"')
      {
         return "@" + STR(p);
      }
      return param;
   };

   const auto mem_vars = HLSMgr->Rmem->get_ext_memory_variables();
   CInitializationParserRef c_initialization_parser(new CInitializationParser(parameters));
   // get the mapping between variables in external memory and their external base address
   std::map<unsigned long long int, unsigned int> address;
   for(const auto& m : mem_vars)
   {
      address[HLSMgr->Rmem->get_external_base_address(m.first)] = m.first;
   }

   std::list<unsigned int> mem;
   for(const auto& ma : address)
   {
      mem.push_back(ma.second);
   }

   const auto func_parameters = BH->get_parameters();
   for(const auto& p : func_parameters)
   {
      // if the function has some pointer func_parameters some memory needs to be reserved for the place where
      // they point to
      if(tree_helper::is_a_pointer(TM, p) && mem_vars.find(p) == mem_vars.end())
      {
         mem.push_back(p);
      }
   }

   const auto fname = tree_helper::GetMangledFunctionName(GetPointerS<const function_decl>(top_fnode));
   const auto func_arch = HLSMgr->module_arch ? HLSMgr->module_arch->GetArchitecture(fname) : nullptr;

   // loop on the test vectors
   unsigned int v_idx = 0;
   for(const auto& curr_test_vector : HLSMgr->RSim->test_vectors)
   {
      const auto get_type_bytes = [&](const unsigned int p, const std::string& param, const bool is_memory)
      {
         std::string test_v = "0";
         if(is_memory)
         {
            test_v = VerilogPrintVarInit(TM, p, HLSMgr->Rmem);
         }
         else if(curr_test_vector.find(param) != curr_test_vector.end())
         {
            test_v = curr_test_vector.find(param)->second;
         }
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "---Initialization string is " + test_v);

         const auto lnode = TM->GetTreeNode(p);
         const auto l_type = tree_helper::CGetType(lnode);
         if(tree_helper::IsPointerType(l_type) && !is_memory)
         {
            if(ends_with(test_v, ".dat"))
            {
               INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "---Binary file initialization");
               if(!std::filesystem::exists(test_v))
               {
                  THROW_ERROR("File does not exist: " + test_v);
               }
               std::ifstream in(test_v, std::ifstream::ate | std::ifstream::binary);
               return static_cast<unsigned long long>(in.tellg());
            }
            else if(flag_cpp)
            {
               const auto base_type_byte_size = [&]() -> unsigned long long
               {
                  const auto ptd_base_type = VerilogPointedType(HLSMgr, parameters, p);
                  std::string param_if_typename;
                  if(func_arch && func_arch->parms.count(param) &&
                     func_arch->parms.at(param).count(FunctionArchitecture::parm_typename))
                  {
                     param_if_typename = func_arch->parms.at(param).at(FunctionArchitecture::parm_typename);
                  }
                  bool is_signed, is_fixed;
                  const auto if_bw = ac_type_bitwidth(param_if_typename, is_signed, is_fixed);
                  if(if_bw)
                  {
                     return get_aligned_ac_bitsize(if_bw) >> 3;
                  }
                  else if(tree_helper::IsArrayType(ptd_base_type))
                  {
                     return get_aligned_bitsize(tree_helper::GetArrayElementSize(ptd_base_type)) >> 3;
                  }
                  return get_aligned_bitsize(tree_helper::SizeAlloc(ptd_base_type)) >> 3;
               }();
               THROW_ASSERT(base_type_byte_size, "");
               const auto splitted = string_to_container<std::vector<std::string>>(test_v, ",");
               INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "---Object size: " + STR(base_type_byte_size));
               INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "---Array  size: " + STR(splitted.size()));
               return splitted.size() * base_type_byte_size;
            }
            else
            {
               const CInitializationParserFunctorRef c_initialization_parser_functor(
                   new ComputeReservedMemory(TM, lnode, VerilogPointedType(HLSMgr, parameters, p)));
               c_initialization_parser->Parse(c_initialization_parser_functor, test_v);
               const auto reserved_bytes =
                   GetPointer<ComputeReservedMemory>(c_initialization_parser_functor)->GetReservedBytes();
               INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "---C object size: " + STR(reserved_bytes));
               return static_cast<unsigned long long>(reserved_bytes);
            }
         }
         else if(!is_memory)
         {
            THROW_ERROR_CODE(NODE_NOT_YET_SUPPORTED_EC, "not yet supported case");
         }
         return std::max(tree_helper::SizeAlloc(l_type) / 8, 8ull);
      };
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Considering test vector " + STR(v_idx));
      HLSMgr->RSim->param_address[v_idx].clear();

      // loop on the variables in memory
      for(auto l = mem.begin(); l != mem.end(); ++l)
      {
         const auto param = get_param_name(*l);
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "-->Considering " + param);
         const auto is_memory = mem_vars.find(*l) != mem_vars.end() &&
                                std::find(func_parameters.begin(), func_parameters.end(), *l) == func_parameters.end();
         if(v_idx > 0 && is_memory)
         {
            INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Skipped " + param);
            continue; // memory has been already initialized
         }
         const auto reserved_bytes = get_type_bytes(*l, param, is_memory);

         if(tree_helper::IsPointerType(TM->GetTreeNode(*l)) && !is_memory)
         {
            if(HLSMgr->RSim->param_address[v_idx].find(*l) == HLSMgr->RSim->param_address[v_idx].end())
            {
               HLSMgr->RSim->param_address[v_idx][*l] = HLSMgr->Rmem->get_memory_address();
               HLSMgr->RSim->param_mem_size[v_idx][*l] = reserved_bytes;
               HLSMgr->Rmem->reserve_space(reserved_bytes);

               INDENT_OUT_MEX(OUTPUT_LEVEL_VERBOSE, output_level,
                              "---Parameter " + param + " (" + STR((*l)) + ") (testvector " + STR(v_idx) +
                                  ") allocated at " + STR(HLSMgr->RSim->param_address.at(v_idx).at(*l)) +
                                  " : reserved_mem_size = " + STR(HLSMgr->RSim->param_mem_size.at(v_idx).at(*l)));
            }
         }

         auto l_next = l;
         ++l_next;
         unsigned long long int next_object_offset = 0;
         const auto& v_param_address = HLSMgr->RSim->param_address.at(v_idx);
         /// check the next free aligned address
         if(l_next != mem.end() && mem_vars.find(*l_next) != mem_vars.end() && mem_vars.find(*l) != mem_vars.end())
         {
            next_object_offset =
                HLSMgr->Rmem->get_base_address(*l_next, function_id) - HLSMgr->Rmem->get_base_address(*l, function_id);
         }
         else if(mem_vars.find(*l) != mem_vars.end() &&
                 (l_next == mem.end() || v_param_address.find(*l_next) == v_param_address.end()))
         {
            next_object_offset = HLSMgr->Rmem->get_memory_address() - HLSMgr->Rmem->get_base_address(*l, function_id);
         }
         else if(l_next != mem.end() && mem_vars.find(*l) != mem_vars.end() &&
                 v_param_address.find(*l_next) != v_param_address.end())
         {
            next_object_offset =
                v_param_address.find(*l_next)->second - HLSMgr->Rmem->get_base_address(*l, function_id);
         }
         else if(l_next != mem.end() && v_param_address.find(*l) != v_param_address.end() &&
                 v_param_address.find(*l_next) != v_param_address.end())
         {
            next_object_offset = v_param_address.find(*l_next)->second - v_param_address.find(*l)->second;
         }
         else if(v_param_address.find(*l) != v_param_address.end())
         {
            next_object_offset = HLSMgr->Rmem->get_memory_address() - v_param_address.find(*l)->second;
         }
         else
         {
            THROW_ERROR("unexpected pattern");
         }

         if(next_object_offset < reserved_bytes)
         {
            THROW_ERROR("more allocated memory than expected  next_object_offset=" + STR(next_object_offset) +
                        " reserved_bytes=" + STR(reserved_bytes));
         }
         HLSMgr->RSim->param_next_off[v_idx][*l] = next_object_offset;

         INDENT_OUT_MEX(OUTPUT_LEVEL_VERBOSE, output_level,
                        "Padding of " + STR(next_object_offset - reserved_bytes) + " for parameter " + param);

         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered " + param);
      }
      INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level, "<--Considered test vector " + STR(v_idx));
      v_idx++;
   }
   return DesignFlowStep_Status::SUCCESS;
}
