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
 * @file verilog_testbench_expected_values.hpp
 * @brief Compute the expected outputs of the self-contained Verilog (bambu 2023.1, XML-driven) testbench by executing
 * the specification on the host.
 *
 * Takes the place of 2023.1's TestbenchValuesCGeneration, whose HLSCWriter was replaced by the DPI-C testbench.
 */
#ifndef VERILOG_TESTBENCH_EXPECTED_VALUES_HPP
#define VERILOG_TESTBENCH_EXPECTED_VALUES_HPP

#include "hls_step.hpp"

#include <filesystem>

class VerilogTestbenchExpectedValues : public HLS_step
{
 protected:
   /// The output directory
   const std::filesystem::path output_directory;

   HLSRelationships ComputeHLSRelationships(const DesignFlowStep::RelationshipType relationship_type) const override;

 public:
   VerilogTestbenchExpectedValues(const ParameterConstRef parameters, const HLS_managerRef hls_manager,
                                  const DesignFlowManagerConstRef design_flow_manager);

   /**
    * When the test vectors carry no expected outputs, write a C driver that calls the top function on every test
    * vector and prints the final content of its pointer parameters (and its return value), build it with the
    * input sources, run it, and store the results in the test vectors as param:output (and return).
    */
   DesignFlowStep_Status Exec() override;

   bool HasToBeExecuted() const override;
};
#endif
