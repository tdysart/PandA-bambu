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
 * @file legacy_testbench_utils.cpp
 * @brief Helpers shared by the legacy (bambu 2023.1, XML-driven) testbench generation steps.
 */
#include "legacy_testbench_utils.hpp"

#include "Parameter.hpp"
#include "behavioral_helper.hpp"
#include "exceptions.hpp"
#include "function_behavior.hpp"
#include "hls_manager.hpp"
#include "string_manipulation.hpp"
#include "tree_helper.hpp"
#include "tree_manager.hpp"
#include "tree_manipulation.hpp"
#include "tree_node.hpp"

#include <regex>
#include <string>
#include <vector>

/// Find a real type of the given precision among the types already used by the design
static tree_nodeConstRef FindRealType(const tree_managerConstRef TM, unsigned long long prec)
{
   for(unsigned int i = 1; i < TM->get_next_available_tree_node_id(); ++i)
   {
      if(TM->is_tree_node(i))
      {
         const auto tn = TM->GetTreeNode(i);
         if(tn->get_kind() == real_type_K && GetPointerS<const real_type>(tn)->prec == prec)
         {
            return tn;
         }
      }
   }
   return tree_nodeConstRef();
}

/// Behavioral helper of the (single) top function
static BehavioralHelperConstRef TopBehavioralHelper(const HLS_managerRef HLSMgr, const ParameterConstRef parameters)
{
   const auto top_symbols = parameters->getOption<std::vector<std::string>>(OPT_top_functions_names);
   THROW_ASSERT(top_symbols.size() == 1, "Expected single top function name");
   const auto top_fnode = HLSMgr->get_tree_manager()->GetFunction(top_symbols.front());
   return HLSMgr->CGetFunctionBehavior(top_fnode->index)->CGetBehavioralHelper();
}

std::string LegacyOriginalTypename(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                   const std::string& param_name)
{
   const auto BH = TopBehavioralHelper(HLSMgr, parameters);
   const auto func_arch = HLSMgr->module_arch ? HLSMgr->module_arch->GetArchitecture(BH->GetMangledFunctionName()) :
                                                FunctionArchitectureRef();
   if(!func_arch || !func_arch->parms.count(param_name) ||
      !func_arch->parms.at(param_name).count(FunctionArchitecture::parm_original_typename))
   {
      THROW_ERROR("Legacy testbench: unknown C type for parameter " + param_name);
   }
   return func_arch->parms.at(param_name).at(FunctionArchitecture::parm_original_typename);
}

std::string LegacyBaseTypename(const std::string& type_name)
{
   /// Strip qualifiers, pointer/reference/array declarators and extra spaces: "const float *" -> "float"
   auto base =
       std::regex_replace(type_name, std::regex(R"(\b(const|volatile|restrict|__restrict__|__restrict)\b)"), " ");
   base = std::regex_replace(base, std::regex(R"(\(\s*\*\s*\)|\[[^\]]*\]|[*&])"), " ");
   base = std::regex_replace(base, std::regex(R"(\s+)"), " ");
   return std::regex_replace(base, std::regex(R"(^ | $)"), "");
}

tree_nodeConstRef LegacyPointedType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                    unsigned int param_index)
{
   const auto TM = HLSMgr->get_tree_manager();
   const auto param_node = TM->GetTreeNode(param_index);
   const auto param_type = tree_helper::CGetType(param_node);
   if(!tree_helper::IsPointerType(param_type))
   {
      return tree_nodeConstRef();
   }
   const auto ptd_type = tree_helper::CGetPointedType(param_type);
   if(!tree_helper::IsVoidType(ptd_type))
   {
      return ptd_type;
   }

   /// Opaque pointer in the IR: recover the pointed type from the original C typename of the top parameter
   const auto param_name = TopBehavioralHelper(HLSMgr, parameters)->PrintVariable(param_index);
   const auto type_name = LegacyOriginalTypename(HLSMgr, parameters, param_name);
   const auto base = LegacyBaseTypename(type_name);

   const auto m64P = parameters->getOption<std::string>(OPT_gcc_m_env).find("-m64") != std::string::npos;
   const tree_manipulation tree_man(TM, parameters, true, HLSMgr);
   const auto int_type = [&](unsigned long long bits, bool is_unsigned) -> tree_nodeConstRef
   { return tree_man.GetCustomIntegerType(bits, is_unsigned); };
   static const std::regex stdint(R"((u?)int(8|16|32|64)_t)");
   std::smatch match;
   if(base == "float" || base == "double")
   {
      const auto real = FindRealType(TM, base == "float" ? 32 : 64);
      if(!real)
      {
         THROW_ERROR("Legacy testbench: no " + base + " type in the design for parameter " + param_name);
      }
      return real;
   }
   else if(base == "_Bool" || base == "bool")
   {
      return tree_man.GetBooleanType();
   }
   else if(base == "char" || base == "signed char")
   {
      return int_type(8, false);
   }
   else if(base == "unsigned char")
   {
      return int_type(8, true);
   }
   else if(base == "short" || base == "short int" || base == "signed short" || base == "signed short int")
   {
      return int_type(16, false);
   }
   else if(base == "unsigned short" || base == "unsigned short int")
   {
      return int_type(16, true);
   }
   else if(base == "int" || base == "signed" || base == "signed int")
   {
      return int_type(32, false);
   }
   else if(base == "unsigned" || base == "unsigned int")
   {
      return int_type(32, true);
   }
   else if(base == "long" || base == "long int" || base == "signed long" || base == "signed long int")
   {
      return int_type(m64P ? 64 : 32, false);
   }
   else if(base == "unsigned long" || base == "unsigned long int")
   {
      return int_type(m64P ? 64 : 32, true);
   }
   else if(base == "long long" || base == "long long int" || base == "signed long long" ||
           base == "signed long long int")
   {
      return int_type(64, false);
   }
   else if(base == "unsigned long long" || base == "unsigned long long int")
   {
      return int_type(64, true);
   }
   else if(std::regex_match(base, match, stdint))
   {
      return int_type(std::stoull(match[2].str()), !match[1].str().empty());
   }
   THROW_ERROR("Legacy testbench: pointed type \"" + type_name + "\" of parameter " + param_name +
               " is not supported yet");
   return tree_nodeConstRef();
}

tree_nodeConstRef LegacyPointedType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                    const std::string& param_name)
{
   const auto BH = TopBehavioralHelper(HLSMgr, parameters);
   for(const auto& p : BH->get_parameters())
   {
      if(BH->PrintVariable(p) == param_name)
      {
         return LegacyPointedType(HLSMgr, parameters, p);
      }
   }
   THROW_ERROR("Legacy testbench: " + param_name + " is not a parameter of the top function");
   return tree_nodeConstRef();
}

tree_nodeConstRef LegacyTypedPointerType(const HLS_managerRef HLSMgr, const ParameterConstRef parameters,
                                         unsigned int param_index)
{
   const auto TM = HLSMgr->get_tree_manager();
   const auto param_type = tree_helper::CGetType(TM->GetTreeNode(param_index));
   if(!tree_helper::IsPointerType(param_type) || !tree_helper::IsVoidType(tree_helper::CGetPointedType(param_type)))
   {
      return param_type;
   }
   const tree_manipulation tree_man(TM, parameters, true, HLSMgr);
   return tree_man.GetPointerType(LegacyPointedType(HLSMgr, parameters, param_index));
}
