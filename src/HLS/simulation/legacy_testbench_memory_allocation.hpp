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
 * @file legacy_testbench_memory_allocation.hpp
 * @brief Reserve memory for the pointer arguments of the top function in the legacy (XML) testbench.
 *
 * Ported from bambu 2023.1 (src/HLS/simulation/testbench_memory_allocation.hpp).
 */
#ifndef LEGACY_TESTBENCH_MEMORY_ALLOCATION_HPP
#define LEGACY_TESTBENCH_MEMORY_ALLOCATION_HPP

#include "hls_step.hpp"

class LegacyTestbenchMemoryAllocation : public HLS_step
{
 private:
   HLSRelationships ComputeHLSRelationships(const DesignFlowStep::RelationshipType relationship_type) const override;

 public:
   LegacyTestbenchMemoryAllocation(const ParameterConstRef _parameters, const HLS_managerRef _HLSMgr,
                                   const DesignFlowManagerConstRef _design_flow_manager);

   /**
    * For every test vector, reserve space in the design memory map for the objects pointed to by the top
    * function arguments, and compute the padding up to the next object.
    */
   DesignFlowStep_Status Exec() override;

   bool HasToBeExecuted() const override;
};
#endif
