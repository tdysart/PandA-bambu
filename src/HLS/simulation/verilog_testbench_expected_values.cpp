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
 * @file verilog_testbench_expected_values.cpp
 * @brief Compute the expected outputs of the self-contained Verilog (bambu 2023.1, XML-driven) testbench by executing
 * the specification on the host.
 */
#include "verilog_testbench_expected_values.hpp"

#include "Parameter.hpp"
#include "SimulationInformation.hpp"
#include "behavioral_helper.hpp"
#include "compiler_wrapper.hpp"
#include "dbgPrintHelper.hpp"
#include "exceptions.hpp"
#include "fileIO.hpp"
#include "function_behavior.hpp"
#include "hls_manager.hpp"
#include "string_manipulation.hpp"
#include "tree_helper.hpp"
#include "tree_manager.hpp"
#include "tree_node.hpp"
#include "utility.hpp"
#include "verilog_testbench_utils.hpp"

#include <algorithm>
#include <fstream>
#include <list>
#include <map>
#include <string>
#include <tuple>
#include <vector>

VerilogTestbenchExpectedValues::VerilogTestbenchExpectedValues(const ParameterConstRef _parameters,
                                                               const HLS_managerRef _hls_manager,
                                                               const DesignFlowManagerConstRef _design_flow_manager)
    : HLS_step(_parameters, _hls_manager, _design_flow_manager, HLSFlowStep_Type::VERILOG_TESTBENCH_EXPECTED_VALUES),
      output_directory(parameters->getOption<std::filesystem::path>(OPT_output_directory) / "simulation")
{
   debug_level = parameters->get_class_debug_level(GET_CLASS(*this));
}

HLS_step::HLSRelationships
VerilogTestbenchExpectedValues::ComputeHLSRelationships(const DesignFlowStep::RelationshipType relationship_type) const
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

bool VerilogTestbenchExpectedValues::HasToBeExecuted() const
{
   return true;
}

/// C statement printing value to the driver's output stream, depending on its type
static std::string PrintValueStatement(const tree_nodeConstRef& type, const std::string& value,
                                       const std::string& param)
{
   if(tree_helper::IsRealType(type))
   {
      const auto bits = tree_helper::Size(type);
      if(bits != 32 && bits != 64)
      {
         THROW_ERROR("Verilog testbench: " + STR(bits) + "-bit floating point type of " + param +
                     " is not supported by the host execution");
      }
      return "__verilog_tb_print_real((double)(" + value + "), " + (bits == 32 ? "1" : "0") + ");";
   }
   if(tree_helper::IsBooleanType(type) || tree_helper::IsUnsignedIntegerType(type))
   {
      return "fprintf(__verilog_tb_out, \"%llu\", (unsigned long long)(" + value + "));";
   }
   if(tree_helper::IsSignedIntegerType(type))
   {
      return "fprintf(__verilog_tb_out, \"%lld\", (long long)(" + value + "));";
   }
   THROW_ERROR("Verilog testbench: the type of " + param + " is not supported by the host execution");
   return "";
}

/// Flatten a C initializer to a single brace level: "{{1,2},{3,4}}" -> "{1,2,3,4}", "5" -> "{5}"
static std::string FlatInitializer(std::string value)
{
   value.erase(std::remove_if(value.begin(), value.end(), [](char c) { return c == '{' || c == '}'; }), value.end());
   return "{" + value + "}";
}

DesignFlowStep_Status VerilogTestbenchExpectedValues::Exec()
{
   if(HLSMgr->RSim->results_available)
   {
      INDENT_DBG_MEX(DEBUG_LEVEL_MINIMUM, debug_level, "---Expected outputs taken from the test vectors");
      return DesignFlowStep_Status::UNCHANGED;
   }
   const auto input_format = parameters->getOption<Parameters_FileFormat>(OPT_input_format);
   if(input_format == Parameters_FileFormat::FF_CPP || input_format == Parameters_FileFormat::FF_LLVM_CPP)
   {
      THROW_ERROR("The Verilog testbench cannot compute expected outputs for C++ input yet: add them to the XML "
                  "test vectors (param:output, param:init_output_file or return attributes)");
   }
   const auto TM = HLSMgr->get_tree_manager();
   const auto top_symbols = parameters->getOption<std::vector<std::string>>(OPT_top_functions_names);
   THROW_ASSERT(top_symbols.size() == 1, "Expected single top function name");
   const auto top_fname = top_symbols.front();
   const auto fnode = TM->GetFunction(top_fname);
   const auto BH = HLSMgr->CGetFunctionBehavior(fnode->index)->CGetBehavioralHelper();
   const auto& function_parameters = BH->GetParameters();
   const auto return_type = tree_helper::GetFunctionReturnType(fnode);

   std::filesystem::create_directories(output_directory);
   const auto driver_filename = output_directory / "verilog_expected_values.c";
   const auto exec_filename = output_directory / "verilog_expected_values";
   const auto results_filename = output_directory / "verilog_expected_values.txt";

   /// Driver: prototype of the top function from the original C types of its parameters
   std::ofstream driver(driver_filename);
   driver << "/* Computes the expected outputs of the Verilog testbench; generated by bambu */\n"
          << "#include <math.h>\n#include <stdbool.h>\n#include <stddef.h>\n#include <stdint.h>\n"
          << "#include <stdio.h>\n\n"
          << "static FILE* __verilog_tb_out;\n\n"
          << "static void __verilog_tb_print_real(double v, int is_float)\n{\n"
          << "   if(isnan(v))\n      fputs(signbit(v) ? \"-NaN\" : \"+NaN\", __verilog_tb_out);\n"
          << "   else if(isinf(v))\n      fputs(v < 0 ? \"-Inf\" : \"+Inf\", __verilog_tb_out);\n"
          << "   else\n      fprintf(__verilog_tb_out, is_float ? \"%.9g\" : \"%.17g\", v);\n}\n\n";
   driver << (return_type ? tree_helper::PrintType(TM, return_type) : std::string("void")) << " " << top_fname << "(";
   std::vector<std::string> param_names;
   for(const auto& function_parameter : function_parameters)
   {
      const auto param = BH->PrintVariable(function_parameter->index);
      driver << (param_names.empty() ? "" : ", ") << VerilogOriginalTypename(HLSMgr, parameters, param);
      param_names.push_back(param);
   }
   driver << ");\n\nint main(int argc, char** argv)\n{\n"
          << "   if(argc != 2 || !(__verilog_tb_out = fopen(argv[1], \"w\")))\n      return 1;\n";

   unsigned int v_idx = 0;
   for(const auto& test_vector : HLSMgr->RSim->test_vectors)
   {
      driver << "   {\n";
      std::string call_args;
      std::string print_outputs;
      for(size_t p = 0; p < function_parameters.size(); ++p)
      {
         const auto& function_parameter = function_parameters.at(p);
         const auto& param = param_names.at(p);
         const auto var = "__verilog_tb_p" + STR(p);
         const auto type_name = VerilogOriginalTypename(HLSMgr, parameters, param);
         if(!test_vector.count(param))
         {
            THROW_ERROR("Verilog testbench: parameter " + param + " has no value in test vector " + STR(v_idx) +
                        ", so its expected output cannot be computed");
         }
         const auto& value = test_vector.at(param);
         if(ends_with(value, ".dat"))
         {
            THROW_ERROR("Verilog testbench: binary initialization files (" + value +
                        ") are not supported by the host execution");
         }
         call_args += (call_args.empty() ? "" : ", ") + var;
         if(tree_helper::IsPointerType(function_parameter))
         {
            driver << "      " << VerilogBaseTypename(type_name) << " " << var << "[] = " << FlatInitializer(value)
                   << ";\n";
            const auto elem_type = VerilogPointedType(HLSMgr, parameters, function_parameter->index);
            print_outputs += "      fputs(\"" + param + " {\", __verilog_tb_out);\n" +
                             "      for(size_t i = 0; i < sizeof(" + var + ") / sizeof(" + var + "[0]); ++i)\n" +
                             "      {\n         if(i)\n            fputc(',', __verilog_tb_out);\n         " +
                             PrintValueStatement(elem_type, var + "[i]", param) + "\n      }\n" +
                             "      fputs(\"}\\n\", __verilog_tb_out);\n";
         }
         else
         {
            driver << "      " << type_name << " " << var << " = " << value << ";\n";
         }
      }
      if(return_type)
      {
         driver << "      " << tree_helper::PrintType(TM, return_type) << " __verilog_tb_ret = " << top_fname << "("
                << call_args << ");\n";
         print_outputs += "      fputs(\"return \", __verilog_tb_out);\n      " +
                          PrintValueStatement(return_type, "__verilog_tb_ret", "the return value") +
                          "\n      fputc('\\n', __verilog_tb_out);\n";
      }
      else
      {
         driver << "      " << top_fname << "(" << call_args << ");\n";
      }
      driver << "      fputs(\"vector " << v_idx << "\\n\", __verilog_tb_out);\n" << print_outputs << "   }\n";
      ++v_idx;
   }
   driver << "   fclose(__verilog_tb_out);\n   return 0;\n}\n";
   driver.close();

   /// Build the driver with the specification
   std::list<std::string> sources = {driver_filename.string()};
   for(const auto& input_file : string_to_container<std::vector<std::string>>(
           parameters->getOption<std::string>(OPT_input_file), STR_CST_string_separator))
   {
      sources.push_back(input_file);
   }
   const auto default_compiler = parameters->getOption<CompilerWrapper_CompilerTarget>(OPT_default_compiler);
   /// O0 as in CTestbenchExecution: recent clang does not respect -fno-strict-aliasing
   const CompilerWrapperConstRef compiler_wrapper(
       new CompilerWrapper(parameters, default_compiler, CompilerWrapper_OptimizationSet::O0));
   std::string compiler_flags = "-fwrapv -fno-strict-aliasing -ffp-contract=off -D'__builtin_bambu_time_start()=' "
                                "-D'__builtin_bambu_time_stop()=' -D__BAMBU_SIM__ ";
   if(parameters->isOption(OPT_tb_extra_gcc_options))
   {
      compiler_flags += parameters->getOption<std::string>(OPT_tb_extra_gcc_options) + " ";
   }
   INDENT_DBG_MEX(DEBUG_LEVEL_MINIMUM, debug_level, "-->Computing the expected outputs on the host");
   compiler_wrapper->CreateExecutable(sources, exec_filename.string(), compiler_flags);
   const auto ret = PandaSystem(parameters, exec_filename.string() + " " + results_filename.string(), false,
                                output_directory / "verilog_expected_values.log");
   if(IsError(ret))
   {
      THROW_ERROR("Error executing the specification to compute the expected outputs of the Verilog testbench (see " +
                  (output_directory / "verilog_expected_values.log").string() + ")");
   }

   /// Store the results in the test vectors
   std::ifstream results(results_filename);
   std::string line;
   size_t curr = 0;
   bool in_vector = false;
   while(std::getline(results, line))
   {
      const auto sep = line.find(' ');
      THROW_ASSERT(sep != std::string::npos, "Unexpected line in " + results_filename.string() + ": " + line);
      const auto key = line.substr(0, sep);
      const auto value = line.substr(sep + 1);
      if(key == "vector")
      {
         curr = std::stoul(value);
         THROW_ASSERT(curr < HLSMgr->RSim->test_vectors.size(), "");
         in_vector = true;
      }
      else
      {
         THROW_ASSERT(in_vector, "");
         HLSMgr->RSim->test_vectors.at(curr)[key == "return" ? key : key + ":output"] = value;
         INDENT_DBG_MEX(DEBUG_LEVEL_VERY_PEDANTIC, debug_level,
                        "---Vector " + STR(curr) + ": expected " + key + " = " + value);
      }
   }
   if(!in_vector || curr + 1 != HLSMgr->RSim->test_vectors.size())
   {
      THROW_ERROR("Incomplete expected outputs in " + results_filename.string());
   }
   HLSMgr->RSim->results_available = true;
   INDENT_OUT_MEX(OUTPUT_LEVEL_MINIMUM, output_level,
                  "---Verilog testbench: expected outputs computed by executing the specification on the host");
   INDENT_DBG_MEX(DEBUG_LEVEL_MINIMUM, debug_level, "<--Computed the expected outputs on the host");
   return DesignFlowStep_Status::SUCCESS;
}
