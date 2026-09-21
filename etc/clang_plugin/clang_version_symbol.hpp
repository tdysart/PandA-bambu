#ifndef CLANG_VERSION_SYMBOL_HPP
#define CLANG_VERSION_SYMBOL_HPP

#if __clang_major__ == 13 || __clang_major__ == 14
/* clang14 is treated as an alias for the "clang13" plugin slot: bambu's
   configure/Makefile machinery on this host maps an actual LLVM 14 install
   into the clang13 slot (v2023.1 predates a real clang14 slot, and no
   compatible clang13 toolchain is available here), so the plugin symbols
   must still be named/labeled "clang13" to match what the rest of the
   build (Makefile.am targets, config headers, tree-panda-gcc, etc.)
   expects for that slot. */
#define CLANG_VERSION_SYMBOL(SYMBOL) clang13##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang13" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang13##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang13##SYMBOL##PluginInfo
#elif __clang_major__ == 12
#define CLANG_VERSION_SYMBOL(SYMBOL) clang12##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang12" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang12##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang12##SYMBOL##PluginInfo
#elif __clang_major__ == 11
#define CLANG_VERSION_SYMBOL(SYMBOL) clang11##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang11" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang11##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang11##SYMBOL##PluginInfo
#elif __clang_major__ == 10
#define CLANG_VERSION_SYMBOL(SYMBOL) clang10##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang10" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang10##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang10##SYMBOL##PluginInfo
#elif __clang_major__ == 9
#define CLANG_VERSION_SYMBOL(SYMBOL) clang9##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang9" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang9##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang9##SYMBOL##PluginInfo
#elif __clang_major__ == 8
#define CLANG_VERSION_SYMBOL(SYMBOL) clang8##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang8" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang8##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang8##SYMBOL##PluginInfo
#elif __clang_major__ == 7 && !defined(VVD)
#define CLANG_VERSION_SYMBOL(SYMBOL) clang7##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang7" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang7##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang7##SYMBOL##PluginInfo
#elif __clang_major__ == 7 && defined(VVD)
#define CLANG_VERSION_SYMBOL(SYMBOL) clangvvd##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clangvvd" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclangvvd##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclangvvd##SYMBOL##PluginInfo
#elif __clang_major__ == 6
#define CLANG_VERSION_SYMBOL(SYMBOL) clang6##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang6" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang6##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang6##SYMBOL##PluginInfo
#elif __clang_major__ == 5
#define CLANG_VERSION_SYMBOL(SYMBOL) clang5##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang5" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang5##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang5##SYMBOL##PluginInfo
#elif __clang_major__ == 4
#define CLANG_VERSION_SYMBOL(SYMBOL) clang4##SYMBOL
#define CLANG_VERSION_STRING(SYMBOL) "clang4" #SYMBOL
#define CLANG_PLUGIN_INIT(SYMBOL) initializeclang4##SYMBOL##Pass
#define CLANG_PLUGIN_INFO(SYMBOL) getclang4##SYMBOL##PluginInfo
#else
#error
#endif

#endif // CLANG_VERSION_SYMBOL_HPP