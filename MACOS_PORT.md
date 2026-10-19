# macOS (arm64) port of `dev/panda`

Status notes for the `spike/devpanda-macos-testbench` branch, which builds upstream
`dev/panda` natively on macOS/arm64. Last updated 2026-10-07.

## Why this branch exists

- `upstream/main` has not moved since April 2025; all development is on `dev/panda`.
- The soda-plugins dataflow lowering (the plugins are in soda-benchmarks, under
  `examples/soda-plugins`) needs two things only `dev/panda` has: the
  `array_dims` parameter attribute in `--architecture-xml`, and the unified
  `ac_channel.h` (channel accesses are `_read_bambu_internal` / `_write_bambu_internal`,
  no nested `fifo` class).
- `dev/panda` replaced autotools with CMake and removed the C++ simulation framework, so the
  macOS/autotools work and the `--testbench-style=verilog` port on
  `feature/legacy-xml-testbench` do not carry over directly. That branch is the earlier
  pure-Verilog testbench port, on the autotools tree (upstream `main` plus the macOS commits);
  `legacy-xml` was this style's old name. The spike redid it on the CMake tree.

## What works

| Area | State |
|------|-------|
| Build (`bambu`, `bambu-cc`, `eucalyptus`, clang plugins, libbambu) | Works with Apple clang + Homebrew `llvm@19`. |
| Plain C to Verilog (including soft-float) | Works. |
| soda-plugins dataflow IR (`gemm_small`) to Verilog | Works with `--generate-interface=INFER`. |
| `--simulate` with the MDPI/DPI runtime | **Does not work; deliberately not fixed. See below.** |

### Build recipe

```bash
brew install llvm@19
export PATH=/opt/homebrew/opt/llvm@19/bin:$PATH
cmake -S . -B build19 -G Ninja \
  -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DCMAKE_INSTALL_PREFIX=$HOME/SODA-OPT/panda/install-devpanda19 \
  -DPANDA_ENABLE_WERROR=OFF -DPANDA_ENABLE_OPT=OFF \
  -DPANDA_LIBBAMBU_COMPILER=I386_CLANG19
ninja -C build19 && cmake --install build19
```

- Use Apple clang, not Homebrew GCC. The clang plugins are loaded into the clang that
  Bambu invokes, so they must use the same C++ library (libc++); GCC's libstdc++ is
  ABI-incompatible with it.
- `~/SODA-OPT/llvm` (LLVM 19.1.5, the version soda-opt pins; see its README) cannot be used: it
  is MLIR-only, static, has no clang, and has RTTI off. RTTI (run-time type information, the
  C++ support behind `dynamic_cast` and `typeid`) is needed by Bambu's clang plugins, whose
  classes derive from LLVM's, and LLVM is built without it by default.
- Use clang 19, the same major version as the LLVM that produced the IR. Clang 16 is where this
  came from: it is the newest clang the earlier autotools Bambu supports (`I386_CLANG16` is the
  last compiler it knows; Homebrew `llvm@16`), so that was the clang used before `dev/panda`.
  LLVM does not promise that an older version reads newer IR, and soda-opt's LLVM 19 IR can use
  syntax that clang 16 does not know, so `dev/panda` uses clang 19 (`I386_CLANG19`).

### Running Bambu from the install

- `settings.sh` uses GNU `readlink -e`; set `BAMBU_HLS` and `BAMBU_HLS_BACKEND_PATH` to the
  install directory by hand, and put `<install>/bin` and `llvm@19/bin` (for `clang-19`)
  on `PATH`.
- Pass `-m64` (no i386 or x32 targets on Darwin) and `--compiler=I386_CLANG19`.
- For dataflow designs pass `--generate-interface=INFER`. Without it Bambu defaults to
  minimal interface generation, forces every interface to `default`, and the `ac_channel`
  reads and writes are never turned into FIFO ports.

## Portability changes made on this branch

- CMake accepts Apple clang as the project compiler on Darwin.
- Plugins link with `-undefined dynamic_lookup`; the Linux-only `-static-libstdc++` and
  `-z nodelete` are skipped on Apple.
- Executables use `-force_load` (not `--whole-archive`) and an `@executable_path` rpath,
  and depend explicitly on `panda_hdl_generators`.
- libbambu archives are built with the detected clang's `llvm-ar`/`llvm-ranlib`: Apple's
  `ar` silently drops LLVM-bitcode members, leaving every archive empty.
- No x32 libbambu on Darwin; `__FP_FAST_FMA` is undefined for the musl libm sources
  (arm64 defines it, which emits `llvm.fma`, an intrinsic the backend cannot lower).
- libc++ source fixes: complete `var_pp_functor`/`memory` types where a `unique_ptr`
  default argument needs them, `<sstream>`, `_NSGetExecutablePath`, `size_t`/`uint64_t`
  in `plugin_customSROA.cpp`.
- glibc-isms in libbambu: `__GNUC_PREREQ`, `<endian.h>`, `isnanf`/`isinff`/`finitef`.
- BSD tool compatibility in the libtech data generation (`sed`, `head -n -N`).
- `-msse2` is only passed on x86 hosts, and the simulation wrapper script no longer
  needs `date +%s.%N`.

## Known limitation: the MDPI simulation path does not run on macOS

**Decision (2026-10-07): not fixing this now.** The pure-Verilog testbench for
verilator-sst does not use libmdpi, so this is off the critical path. Revisit it if we
need upstream's own `--simulate` flow on macOS.

### How far it gets

With `--simulate --simulator=VERILATOR --generate-tb=<c file with main>`, a small C
vector-add kernel synthesizes to Verilog and the generated simulation scripts start. The
failures, in order, and their status:

1. **GNU tools assumed by the generated scripts.** `evaluate_*.sh` and `launch.sh` use
   `readlink -e`, and `xmlq` uses gawk's three-argument `match()`. Worked around outside
   the repo by putting `readlink` (-> `greadlink`) and `awk` (-> `gawk`) from Homebrew
   `coreutils`/`gawk` first on `PATH`. Not changed in the repo.
2. **`-msse2`** passed to the testbench compile. Fixed (x86-only now).
3. **`date +%s.%N`** in `simulation_wrapper.sh`. Fixed (falls back to whole seconds).
4. **ELF `objcopy` in `etc/libmdpi/Makefile.mk`. Blocking.**

### The blocker

`etc/libmdpi/Makefile.mk` post-processes object files with GNU/ELF `objcopy`:

| Use | Command |
|-----|---------|
| Rename the top function in the HLS sources, so the C model survives as `__m_<top>` | `objcopy --weaken --redefine-sym <top>=__m_<top>` |
| Weaken the testbench's own definition of the top function, so the DPI wrapper's `<top>` wins at link time | `objcopy -W <top>` |
| Redirect `exit`, `abort`, `__assert_fail` to `__m_*` | `objcopy --redefine-sym ...` |
| Drop all but a few symbols from the pretty-print object | `objcopy --keep-global-symbol ...` |

macOS has no GNU `objcopy`. On this machine `objcopy` resolves to `~/.local/bin/objcopy`,
a shim to Homebrew `llvm@16`'s `llvm-objcopy` (16.0.6), which fails the Makefile with
"option is not supported for MachO" on `--weaken`. `llvm-objcopy` from `llvm@19` was tried
directly on a Mach-O object:

- `--redefine-sym` works, but names need the leading underscore (`_top=__m_top`).
- `--weaken`, `-W` and `--weaken-symbol` are accepted but **do nothing**, so the
  testbench's own `top` stays a strong symbol and cannot be overridden by the DPI
  wrapper's `top`.

Other Linux-isms in the same Makefile, not yet reached: `-Wl,-z,defs`, `-Bsymbolic`,
`-D_GNU_SOURCE`, `-ldl`, `realpath --relative-to`, and the `get_pc_thunk` symbol handling.
The `mdpi_driver`/`mdpi_ipc*` sources also carry Darwin changes on the autotools branch
(`feature/legacy-xml-testbench`: `mdpi_ipc_sig.h`, `mdpi_types.h`, `mdpi_driver.cpp`) that
would have to be redone against the rewritten `etc/libmdpi`.

### If we pick this up later

- Replace the weakening with something Mach-O can express: compile the testbench with the
  top function marked `__attribute__((weak))` (for example by injecting a declaration via
  `-include`), or link the DPI wrapper first with `-Wl,-multiply_defined,suppress`/an
  equivalent, or rename the symbol in the C front end instead of post-processing.
- Do the `--redefine-sym` renames with `llvm-objcopy` and a `_` prefix on Mach-O.
- Port the Darwin changes from the autotools branch's libmdpi onto `etc/libmdpi`.
- Make the generated scripts portable (`readlink -e`, gawk-only `xmlq`) instead of shimming.

## Pure-Verilog testbench: `--testbench-style=verilog`

This style is Bambu's original testbench: an HDL testbench driven by test vectors, with no host
process. It was the standard implementation up to the v2023.1 tag, before the DPI/C++ rework, and
it is what the verilator-sst flow needs.

Status: working for array and scalar-port interfaces with `--simulator=VERILATOR`, including
several calls of the top function in one testbench. No libmdpi, no host process, no ELF
tooling, so it runs on macOS.

```bash
bambu -m64 k.c --top-fname=vadd --compiler=I386_CLANG19 --device-name=nangate45 --clock-period=5 \
  --simulate --simulator=VERILATOR --testbench-style=verilog --generate-interface=INFER --generate-tb=k.c
```

How it works (backend `etc/libtech/backend/simulation/verilator_verilog/`):

1. **Capture.** `launch.sh` compiles the user's testbench with a capture runtime
   (`capture/include/mdpi/mdpi_wrapper.h`) in place of libmdpi, and links it with the generated
   `mdpi_wrapper.cpp`, the reference (gold) build of the sources, and the testbench. It runs
   natively. At each call of the top function the wrapper records the input memory in
   `tb_init.mem` and, after the reference run, the output in `tb_expected.mem`
   (`<run> <interface id> <element address> <data>`). The reference result is also copied back
   into the host arrays, so the testbench's own checks and calls that depend on earlier results
   see correct data. The top function in the testbench is made weak with `#pragma weak`, which
   replaces the ELF `objcopy` weakening that Mach-O cannot do.
2. **Simulate.** The generated `bambu_testbench.v` is verilated with `BAMBU_TB_VERILOG`, which
   makes the library components import `tb_shim_pkg` (an in-simulation memory) instead of the
   five DPI functions (`NC_TESTBENCH_IPs.xml`). Before each run the shim loads that run's input
   image, after it checks the run against the expected image.
3. **Results.** `bambu_time_simulation.txt` is converted to `bambu_results.xml`, so the stock
   `Evaluation` step reports cycles and executions.

Under verilator-sst: the generated `bambu_testbench.v` has a single `clock` port, so it runs as
a verilator-sst custom module (`scripts/verilator_sst_devpanda_tb.sh` in soda-benchmarks). The
dataflow `forward` design takes 1849 cycles there as well, identical to the native run. The
final block of `TestbenchFSM` runs once (`sim_ended`), because `$finish` only raises a flag
under Verilator and SST keeps clocking after it.

Regression: `panda_regressions/hls/bambu_verilog_testbench/run.sh [install_dir]` (single run,
three runs with a dependent call, the soda-plugins dataflow `forward` design, and an injected
mismatch for each).

### Dataflow designs from LLVM IR

The soda-plugins `forward` design (three nodes joined by FIFOs, `D = 0.5*(A*B) + 0.1f*C`) runs
in this testbench: 1849 cycles, all 32 output words bit-exact against the reference model, and a
one-ulp corruption of the expected image is detected. Notes:

- The design has no C source, so when every source is LLVM IR, `launch.sh` uses the testbench
  file's own definition of the top function as the reference model (the IR cannot run natively:
  its `ac_channel` seams only exist in hardware).
- The plugin must be told the word size of the machine it targets: use
  `machine-bits=64` with `bambu -m64`. Its default, `-m32`, has no sysroot on arm64 macOS.
- Pass `--generate-interface=INFER` as for any dataflow design.

`m_axi` pointer parameters work too: the capture maps each host buffer at a device address
(as the wrapper's `__m_memmap` does), records the address as the pointer port's value and the
buffer in a byte-addressed memory, and the shim serves reads and writes of any width at any byte
address (little endian). The 3mm example (seven `m_axi` buffers, 26322 cycles) runs this way.
A testbench with `void*` parameters must say how big the buffers are with `m_param_alloc`, as it
does for the MDPI flow. The image files hold `w` records (element-addressed words and scalar
ports) and `m` records (byte-addressed memory); see `capture/include/mdpi/mdpi_wrapper.h`.

`dev/panda` reads interface pragmas in the form `#pragma HLS interface port=P0 mode=m_axi
offset=direct bundle=gmem0`; the older `#pragma HLS_interface P0 m_axi direct` is ignored, and
`-lm`, `--soft-float`, `--verilator-parallel` and `-v3` are no longer options.

Not supported yet (the capture step stops with a clear error where it can tell):

- Internal memory-mapped variables (global arrays initialised through `memmap_init`).
- FIFO/AXIS, channel, m_axi and banked interfaces on the top function, and return values.
  (FIFOs between dataflow modules inside the design are hardware and are not affected.)
- XML test-vector input (`--generate-tb=<xml>`) has not been tried; it goes through the same
  generated wrapper, so it should work.
- Simulators other than Verilator.
- The shim keeps its images in associative arrays and scans them per run, which is fine for
  small kernels but will be slow for large memories.
