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
 * @file LegacyVerilatorWrapper.hpp
 * @brief Verilator simulation of the legacy (bambu 2023.1) self-contained Verilog testbench.
 *
 * The legacy testbench (--testbench-style=legacy) needs neither libmdpi nor a C driver process: the verilated
 * testbench_<top>_tb module is run by the generated testbench_<top>_main.cpp, and results are read back from
 * the 2023.1 results.txt format (one "<status> <cycles>" line per test vector).
 * Ported from bambu 2023.1 (VerilatorWrapper::GenerateScript and SimulationTool::DetermineCycles).
 */
#ifndef LEGACY_VERILATOR_WRAPPER_HPP
#define LEGACY_VERILATOR_WRAPPER_HPP

#include "SimulationTool.hpp"

class LegacyVerilatorWrapper : public SimulationTool
{
   std::string GenerateScript(std::ostream& script, const std::string& top_filename,
                              const std::list<std::string>& file_list) override;

   /**
    * Parse the 2023.1 results.txt format
    */
   void DetermineLegacyCycles(unsigned long long& accum_cycles, unsigned long long& n_testcases);

 public:
   LegacyVerilatorWrapper(const ParameterConstRef& Param, const std::string& top_fname, const std::string& inc_dirs);

   std::string GenerateSimulationScript(const std::string& top_filename, std::list<std::string> file_list) override;

   void Simulate(unsigned long long& accum_cycles, unsigned long long& n_testcases) override;
};
#endif
