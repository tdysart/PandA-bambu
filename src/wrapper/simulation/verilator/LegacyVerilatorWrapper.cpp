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
 * @file LegacyVerilatorWrapper.cpp
 * @brief Verilator simulation of the legacy (bambu 2023.1) self-contained Verilog testbench.
 *
 * Ported from bambu 2023.1 (VerilatorWrapper::GenerateScript and SimulationTool::DetermineCycles).
 */
#include "LegacyVerilatorWrapper.hpp"

#include "Parameter.hpp"
#include "ToolManager.hpp"
#include "dbgPrintHelper.hpp"
#include "exceptions.hpp"
#include "fileIO.hpp"
#include "string_manipulation.hpp"
#include "testbench_generation_constants.hpp"
#include "utility.hpp"

#include <boost/algorithm/string/trim.hpp>
#include <boost/lexical_cast.hpp>

#include <filesystem>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

LegacyVerilatorWrapper::LegacyVerilatorWrapper(const ParameterConstRef& _Param, const std::string& _top_fname,
                                               const std::string& _inc_dirs)
    : SimulationTool(_Param, _top_fname, _inc_dirs)
{
   PRINT_OUT_MEX(OUTPUT_LEVEL_PEDANTIC, output_level, "Creating the legacy VERILATOR wrapper...");
}

std::string LegacyVerilatorWrapper::GenerateScript(std::ostream& script, const std::string& top_filename,
                                                   const std::list<std::string>& file_list)
{
   for(const auto& file : file_list)
   {
      if(file.find(".vhd") != std::string::npos)
      {
         THROW_ERROR_CODE(NODE_NOT_YET_SUPPORTED_EC, "Mixed simulation not supported by Verilator");
      }
   }
   const auto generate_vcd_output = Param->isOption(OPT_generate_vcd) && Param->getOption<bool>(OPT_generate_vcd);
   const auto output_directory = Param->getOption<std::filesystem::path>(OPT_output_directory);
   const auto obj_dir = beh_dir / "verilator_obj";
   log_file = (beh_dir / (top_filename + "_verilator.log")).string();

   script << "export VM_PARALLEL_BUILDS=1\n";
#ifdef _WIN32
   /// this removes the dependency from perl on MinGW32
   script << "verilator_bin";
#else
   script << "verilator";
#endif
   script << " --cc --exe --Mdir " << obj_dir.string() << " -Wno-fatal -Wno-lint -sv -O3"
          << " --output-split-cfuncs 3000 --output-split-ctrace 3000";
   if(!generate_vcd_output)
   {
      script << " --x-assign fast --x-initial fast --noassert";
   }
   if(Param->isOption(OPT_verilator_parallel) && Param->getOption<int>(OPT_verilator_parallel) > 1)
   {
      script << " --threads " << Param->getOption<int>(OPT_verilator_parallel);
   }
   if(generate_vcd_output)
   {
      script << " --trace --trace-underscore";
   }
   /// The testbench defines HALF_CLOCK_PERIOD as one simulator tick for Verilator: collapse the time unit onto
   /// the time precision, as bambu 2023.1 always did when Verilator supported it
   const auto timescale_override =
       Param->isOption(OPT_verilator_timescale_override) ?
           Param->getOption<std::string>(OPT_verilator_timescale_override) :
           (system("bash -c \"verilator --help 2>&1 | grep -q -- '--timescale-override'\" > /dev/null 2>&1") == 0 ?
                std::string("1ps/1ps") :
                std::string());
   if(!timescale_override.empty())
   {
      script << " --timescale-override \"" << timescale_override << "\"";
   }
   for(const auto& file : file_list)
   {
      script << " " << file;
   }
   script << " " << (output_directory / "simulation" / ("testbench_" + top_filename + "_tb.v")).string()
          << " --top-module " << top_filename << "_tb\n"
          << "if [ $? -ne 0 ]; then exit 1; fi\n\n"
          << "ln -sf " << std::filesystem::absolute(output_directory).string() << " " << obj_dir.string()
          << " || true\n";

   const auto nThreadsMake =
       Param->isOption(OPT_verilator_parallel) ? Param->getOption<int>(OPT_verilator_parallel) : 1;
   script << "make -C " << obj_dir.string() << " -j " << nThreadsMake << " OPT=\"-fstrict-aliasing\" -f V"
          << top_filename << "_tb.mk V" << top_filename << "_tb";
#ifdef _WIN32
   /// VM_PARALLEL_BUILDS=1 removes the dependency from perl
   script << " VM_PARALLEL_BUILDS=1 CFG_CXXFLAGS_NO_UNUSED=\"\"";
#endif
   script << "\n\n";

   return (obj_dir / ("V" + top_filename + "_tb")).string() + " 2>&1 | tee " + log_file;
}

std::string LegacyVerilatorWrapper::GenerateSimulationScript(const std::string& top_filename,
                                                             std::list<std::string> file_list)
{
   generated_script = "simulate_" + top_filename + ".sh";
   std::ofstream script(generated_script);
   std::filesystem::permissions(generated_script,
                                std::filesystem::perms::owner_exec | std::filesystem::perms::group_exec |
                                    std::filesystem::perms::others_exec,
                                std::filesystem::perm_options::add);
   script << "#!/bin/bash\n"
          << "##########################################################\n"
          << "#     Automatically generated by the PandA framework     #\n"
          << "##########################################################\n"
          << "# Simulation script for COMPONENT: " << top_filename << "\n"
          << "# Legacy self-contained Verilog testbench (--testbench-style=legacy)\n"
          << "set -e\n"
          << "cd " << std::filesystem::current_path().string() << "\n\n";

   const auto sim_cmd = GenerateScript(script, top_filename, file_list);
   script << sim_cmd << "\n"
          << "exit ${PIPESTATUS[0]}\n";
   return generated_script;
}

void LegacyVerilatorWrapper::Simulate(unsigned long long& accum_cycles, unsigned long long& n_testcases)
{
   if(generated_script.empty())
   {
      THROW_ERROR("Simulation script not yet generated");
   }

   /// remove previous simulation results
   const auto result_file = Param->getOption<std::string>(OPT_simulation_output);
   if(std::filesystem::exists(result_file))
   {
      std::filesystem::remove_all(result_file);
   }
   ToolManagerRef tool(new ToolManager(Param));
   tool->configure("./" + generated_script, "");
   std::vector<std::string> parameters, input_files, output_files;
   tool->execute(parameters, input_files, output_files,
                 Param->getOption<std::string>(OPT_output_temporary_directory) + "/simulation_output", true);

   DetermineLegacyCycles(accum_cycles, n_testcases);
}

void LegacyVerilatorWrapper::DetermineLegacyCycles(unsigned long long& accum_cycles, unsigned long long& n_testcases)
{
   const auto discrepancy_enabled = Param->isOption(OPT_discrepancy) && Param->getOption<bool>(OPT_discrepancy);
   unsigned long long int num_cycles = 0;
   unsigned long long i = 0;
   const auto result_file = Param->getOption<std::string>(OPT_simulation_output);
   if(!std::filesystem::exists(result_file))
   {
      if(output_level != OUTPUT_LEVEL_VERBOSE)
      {
         CopyStdout(log_file);
      }
      THROW_ERROR("The simulation does not end correctly");
   }
   std::ifstream res_file(result_file);
   if(!res_file.is_open())
   {
      CopyStdout(log_file);
      THROW_ERROR("Result file not correctly created");
   }
   PRINT_OUT_MEX(OUTPUT_LEVEL_PEDANTIC, output_level, "File \"" + result_file + "\" opened");
   std::string line;
   while(std::getline(res_file, line))
   {
      boost::algorithm::trim(line);
      if(line.empty())
      {
         continue;
      }
      /// <status>\t<cycles>[\t<time unit>]; status: 1 pass, 0 mismatch, X timeout, - no expected outputs,
      /// 3 terminated by __builtin_exit
      std::vector<std::string> filevalues;
      {
         std::istringstream fields(line);
         std::string field;
         while(fields >> field)
         {
            filevalues.push_back(field);
         }
      }
      if(filevalues[0] == "X")
      {
         CopyStdout(log_file);
         if(!discrepancy_enabled)
         {
            THROW_ERROR("Simulation not terminated!");
         }
         break;
      }
      else if(filevalues[0] == "0")
      {
         CopyStdout(log_file);
         if(!discrepancy_enabled)
         {
            THROW_ERROR("Simulation not correct!");
         }
         break;
      }
      else if(filevalues[0] == "-")
      {
         THROW_WARNING("Simulation completed but it is not possible to determine if it is correct!");
      }
      else if(filevalues[0] != "1" && filevalues[0] != "3")
      {
         CopyStdout(log_file);
         THROW_ERROR("String not valid: " + line);
      }
      if(filevalues.size() < 2)
      {
         THROW_ERROR("String not valid: " + line);
      }
      auto sim_cycles = boost::lexical_cast<unsigned long long int>(filevalues[1]);
      if(filevalues.size() == 3)
      {
         /// Time reported by library modules (e.g. __builtin_exit) instead of cycles
         auto offset = 0ull;
         if(filevalues[2] == "ns" || filevalues[2] == "ps")
         {
            if(filevalues[0] == "3")
            {
               offset = 1ull;
               sim_cycles -= (filevalues[2] == "ps" ? 1000ull : 1ull) * std::stoull(STR_CST_INIT_TIME);
            }
            /// one Verilator clock cycle is two simulator ticks
            sim_cycles = offset + sim_cycles / (filevalues[2] == "ps" ? 2000ull : 2ull) - 2;
         }
         else
         {
            THROW_ERROR("Unexpected time unit: " + filevalues[2]);
         }
      }
      PRINT_OUT_MEX(OUTPUT_LEVEL_VERBOSE, output_level,
                    (i + 1) << ". Simulation completed with SUCCESS; Execution time " << sim_cycles << " cycles;");
      num_cycles += sim_cycles;
      i++;
   }

   if(i == 0)
   {
      if(!discrepancy_enabled)
      {
         THROW_ERROR(
             "Expected a number of cycles different from zero. Something wrong happened during the simulation!");
      }
      num_cycles = i = 1;
   }
   accum_cycles = num_cycles;
   n_testcases = i;
}
