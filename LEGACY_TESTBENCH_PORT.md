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
- [ ] `SimulationInformation`: restore `param_address`, `param_mem_size`,
      `param_next_off`, `simulationArgSignature`, `results_available`
- [ ] `TestVectorParser`: parse expected outputs again (`:output`,
      `:init_output_file`, `return`). The DPI C writer looks parameters up by
      name, so the extra keys don't affect it.
- [ ] Port `TestbenchMemoryAllocation` (reserve per-argument buffers in `Rmem`)
- [ ] Port `TestbenchValuesXMLGeneration` (writes `simulation/values.txt`)
- [ ] Port `TestbenchGenerationBaseStep` and `MinimalInterfaceTestbench`
      (Verilator path only) as the legacy testbench generation step
- [ ] Hook the steps in: `TestbenchGeneration` delegates to them for
      `legacy`/`both`, and `GenerateSimulationScripts` skips the DPI C-backend
      steps for `legacy`
- [ ] Legacy Verilator simulation script and the old `results.txt` parser
      (`<pass> <cycles>` per line) for `SimulationEvaluation`
- [ ] Validate against bambu 2023.1 on the same input (the soda-benchmarks
      3mm example). The testbench should differ only where the 2024 DUT does.

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
