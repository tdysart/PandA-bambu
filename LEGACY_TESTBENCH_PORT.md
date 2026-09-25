# Porting the bambu 2023.1 XML testbench generator

Working notes for `feature/legacy-xml-testbench`. This branch brings back the
self-contained Verilog testbench that bambu 2023.1 generated from an XML test
vector (`--generate-tb=<file.xml>`). Upstream removed that generator in 2023
in favor of the DPI-C co-simulation testbench (libmdpi).

The old testbench is a single Verilog module whose only port is `clock`.
Stimulus, a memory model, result checking and `results.txt` output all live
inside that module. That makes it usable in environments that can't host
DPI-C or a second process, such as verilator-sst.

## Selection

`--testbench-style=dpi|legacy|both` (default `dpi`, which leaves current
behavior unchanged):

- `legacy`: generate and simulate the ported testbench only.
- `both`: generate both testbenches; simulation uses the DPI-C one.

The ported generator is currently limited to the minimal interface,
`--simulator=VERILATOR`, and a single XML `--generate-tb` file. These limits
are checked in `BambuParameter.cpp`.

## Source of the ported code

The `v2023.1` tag in this repository, e.g.
`git show v2023.1:src/HLS/simulation/testbench_generation_base_step.cpp`.
The generator was removed by these upstream commits:

- 608d896b9: testbench_values_{c,xml}_generation
- 16403313c: testbench_generation_base_step, minimal/wishbone_interface_testbench
- 4ee27c6eb: testbench_memory_allocation, and SimulationInformation fields

These helpers from 2023.1 are still in the tree, unused, and can be reused:
`memory_initialization_writer{,_base}`, `memory_initialization_c_writer`,
`compute_reserved_memory`, `c_initialization_parser*`.

## Expected values

2023.1 had two sources for the values the testbench checks against:

1. **XML**: `param:output`, `param:init_output_file` and `return`
   attributes (`TestbenchValuesXMLGeneration`). **Phase 1.**
2. **Host run**: compile and run the C to compute them
   (`TestbenchValuesCGeneration` with the pre-DPI `HLSCWriter`). **Phase 2.**
   2024's `HLSCWriter` was rewritten for DPI, so this needs the old writer
   ported alongside it.

## Plan (phase 1)

- [x] `--testbench-style` option and parameter checks
- [x] `SimulationInformation`: restore `param_address`, `param_mem_size`,
      `param_next_off`, `simulationArgSignature`, `results_available`
- [x] `TestVectorParser`: parse expected outputs again (`:output`,
      `:init_output_file`, `return`). The DPI C writer looks parameters up by
      name, so the extra keys don't affect it.
- [x] Port `TestbenchMemoryAllocation` (reserve per-argument buffers in `Rmem`)
- [x] Port `TestbenchValuesXMLGeneration` (writes `simulation/values.txt`)
- [x] Port `TestbenchGenerationBaseStep` and `MinimalInterfaceTestbench`
      as `LegacyTestbenchGenerationBaseStep`/`LegacyMinimalInterfaceTestbench`
      (mechanical rewrite of the 2023.1 sources plus the API fixes below)
- [x] Hook the steps in: `TestbenchGeneration` depends on them for
      `legacy`/`both`, and `GenerateSimulationScripts` skips the DPI C-backend
      steps for `legacy`
- [x] `LegacyVerilatorWrapper`: plain Verilator script and the 2023.1
      `results.txt` parser, selected by `SimulationTool::CreateSimulationTool`
      for `legacy`
- [x] Validate on the soda-benchmarks 3mm kernel (llvm-cbe C, asap7-BC, 5 ns):
      `legacy` passes in 15476 cycles, the same count as the DPI testbench on
      the same XML. `both` passes and generates both testbenches, and a
      corrupted expected output fails with "Simulation not correct!". The
      generated testbench matches 2023.1's except where the DUT changed
      (address width, memory layout, `Mout_back_pressure`).
- [x] Validate from soda-opt's LLVM IR directly (no llvm-cbe), with
      `--architecture-xml` giving the pointer arguments' C types and expected
      outputs from a host run of the IR (soda-benchmarks
      `scripts/mkinc/llvm_to_verilog_legacy_tb.mk`): passes in 15473 cycles
      with Verilator and under SST (verilator-sst), and a corrupted expected
      output fails.

## Findings

Things that differ from simply restoring the 2023.1 code:

- **Opaque pointers.** With clang 16 the IR only has `void*` for pointer
  arguments, so the 2023.1 code sized buffers as bytes and failed on `void`.
  `LegacyPointedType` rebuilds the pointed type from the parameter's
  `parm_original_typename` in `module_arch` (C scalar types for now).
  `MemoryInitializationWriter` and `ComputeReservedMemory` take an optional
  type override for it. Port types can't identify parameters any more, since
  all pointers share one type node, so ports are matched by name.
- **`Mout_back_pressure`.** The 2024 DUT has a memory back-pressure input.
  The legacy memory model never stalls, so it is tied to 0.
- **Start race.** `currTime` was updated with a blocking assignment in a
  posedge block, while `next_start_port` is derived combinationally from it
  and sampled by two other posedge blocks. Depending on evaluation order the
  DUT could start without the stimuli being read. It passed by luck with the
  2023.1 DUT and hung with the 2024 one. It is now a non-blocking assignment.
- **Floating point expected outputs from XML** were written byte by byte,
  while the testbench compares real values element by element (ULP). 2023.1
  used this path only with the C-based values generation, which wrote them
  full width. The XML writer now does the same.
- **LLVM IR input.** Without a C front end, `InterfaceInfer` names every
  pointer argument's type `void*`, so `LegacyPointedType` has nothing to go
  on. Passing `--architecture-xml` with `original_typename="float*"` (the
  format bambu's clang plugin writes) fixes it; the parameters are `P0..PN`.
- **Relative paths.** The testbench opens `HLS_output/simulation/values.txt`
  and `results.txt` relative to the working directory (2023.1 used absolute
  paths), so it must run from bambu's output directory.
- **`--timescale-override 1ps/1ps`.** 2024 no longer sets it, but the testbench's
  `HALF_CLOCK_PERIOD 1` relies on it. `LegacyVerilatorWrapper` probes
  Verilator and passes it.

## Next

- Phase 2: expected values from a host execution of the C code (port the
  pre-DPI `HLSCWriter`), so the XML only needs inputs
- Struct/array element types in `LegacyPointedType`
- Non-Verilator simulators (the `_tb_top` wrapper path is ported but unused)

## API changes to expect (2023.1 to 2024.10)

- `ComputeHLSRelationships` returns `HLS_step::HLSRelationships`
- Tree access: `GET_NODE`/`GET_CONST_NODE`/`CGetTreeReindex` are gone; use
  `TM->GetTreeNode(i)` and plain `tree_nodeRef`
- Interface attributes moved from `HLSMgr->design_attributes` to
  `HLSMgr->module_arch->GetArchitecture(mangled)`
- The top function comes from `OPT_top_functions_names` and
  `TM->GetFunction`, not `GetRootFunctions()`
- `std::filesystem` instead of `GetPath`/`BuildPath`/`GetDirectory`
- `tree_helper::SizeAlloc` for memory sizes
- `OPT_testbench_input_xml` became `OPT_testbench_input_file`
- `SimulationTool::DetermineCycles` and the script generator assume
  DPI/IPC and the new `results.txt` format
