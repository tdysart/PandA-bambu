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
 * @file verilog_testbench_values_xml_generation.hpp
 * @brief Write the stimulus/expected-values file (simulation/values.txt) of the Verilog testbench from the XML
 * test vectors.
 *
 * Ported from bambu 2023.1 (src/HLS/simulation/testbench_values_xml_generation.hpp).
 */
#ifndef VERILOG_TESTBENCH_VALUES_XML_GENERATION_HPP
#define VERILOG_TESTBENCH_VALUES_XML_GENERATION_HPP

#include "hls_step.hpp"

#include <filesystem>

CONSTREF_FORWARD_DECL(tree_manager);

class VerilogTestbenchValuesXMLGeneration : public HLS_step
{
 protected:
   /// The tree manager
   const tree_managerConstRef TM;

   /// The output directory
   const std::filesystem::path output_directory;

   HLSRelationships ComputeHLSRelationships(const DesignFlowStep::RelationshipType relationship_type) const override;

 public:
   VerilogTestbenchValuesXMLGeneration(const ParameterConstRef parameters, const HLS_managerRef hls_manager,
                                       const DesignFlowManagerConstRef design_flow_manager);

   /**
    * Write values.txt: base address, memory initialization, input parameters and expected outputs for every
    * test vector.
    */
   DesignFlowStep_Status Exec() override;

   bool HasToBeExecuted() const override;
};
#endif
