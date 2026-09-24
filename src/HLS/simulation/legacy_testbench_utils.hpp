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
 * @file legacy_testbench_utils.hpp
 * @brief Helpers shared by the legacy (bambu 2023.1, XML-driven) testbench generation steps.
 */
#ifndef LEGACY_TESTBENCH_UTILS_HPP
#define LEGACY_TESTBENCH_UTILS_HPP

#include "Parameter.hpp"
#include "testbench_generation.hpp"

#include <boost/algorithm/string/join.hpp>

#include <string>

/// Basename of the stimulus file read by the legacy testbench (2023.1's STR_CST_testbench_generation_basename)
#define STR_CST_legacy_testbench_values_basename "values"

/**
 * Initialization string of a variable as a comma-separated list of binary strings, as returned by 2023.1's
 * TestbenchGenerationBaseStep::print_var_init.
 */
inline std::string LegacyPrintVarInit(const tree_managerConstRef TM, unsigned int var, const memoryRef mem)
{
   return boost::algorithm::join(TestbenchGeneration::print_var_init(TM, var, mem), ",");
}

REF_FORWARD_DECL(HLS_manager);
CONSTREF_FORWARD_DECL(tree_node);

/**
 * Pointed type of a pointer parameter of the top function. With opaque pointers the IR only has void*, so the
 * type is rebuilt from the original C typename of the parameter (module_arch parm_original_typename).
 * @return the pointed type, or null if the parameter is not a pointer
 */
tree_nodeConstRef LegacyPointedType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                    unsigned int param_index);

/**
 * As LegacyPointedType, with the parameter of the top function identified by name (e.g. from a DUT port name:
 * with opaque pointers all pointer parameters share the same type node, so port types cannot identify them)
 */
tree_nodeConstRef LegacyPointedType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                    const std::string& param_name);

/**
 * Type of a parameter of the top function, with an opaque (void) pointer replaced by a pointer to the type
 * returned by LegacyPointedType.
 */
tree_nodeConstRef LegacyTypedPointerType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                         unsigned int param_index);

/// true when the legacy testbench generator has been requested (--testbench-style=legacy|both)
inline bool LegacyTestbenchRequested(const ParameterConstRef parameters)
{
   return parameters->isOption(OPT_testbench_style) && parameters->getOption<std::string>(OPT_testbench_style) != "dpi";
}

/// true when the legacy testbench generator is the only one requested (--testbench-style=legacy)
inline bool LegacyTestbenchOnly(const ParameterConstRef parameters)
{
   return parameters->isOption(OPT_testbench_style) &&
          parameters->getOption<std::string>(OPT_testbench_style) == "legacy";
}
#endif
