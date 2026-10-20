# macOS (arm64) port of upstream `dev/panda`, and its pure-Verilog testbench

Notes for the `spike/devpanda-macos-testbench` branch of
[tdysart/PandA-bambu](https://github.com/tdysart/PandA-bambu): upstream `dev/panda`, built
natively on macOS/arm64, plus a DPI-free Verilog testbench (`--testbench-style=verilog`) that
runs under Verilator and verilator-sst. Last updated 2026-10-19.

Naming: "upstream `dev/panda`" is the development branch of
[ferrandi/PandA-bambu](https://github.com/ferrandi/PandA-bambu); "this branch" is
`spike/devpanda-macos-testbench` of the fork, which is upstream `dev/panda` plus the macOS port and
`--testbench-style=verilog` (upstream `dev/panda` has neither).

Status: **experimental.** It works for the cases below and has a regression suite, but it is a
spike branch that upstream has not seen. How to drive it from
[tdysart/soda-benchmarks](https://github.com/tdysart/soda-benchmarks) (make targets, examples,
models, results, flow-side troubleshooting) is documented there, in `docs/PureVerilogTestbench.md`
and `docs/FlowSurvey.md` on branch `tjd-verilator-sst`; this file covers bambu itself.

| Works | Does not (yet) |
|-------|----------------|
| Building bambu, `bambu-cc`, `eucalyptus`, the clang plugins and libbambu on macOS arm64 | `--testbench-style=mdpi` (upstream's DPI simulation) on macOS |
| C and LLVM IR input to Verilog, including soft-float | Top-level FIFO/AXIS/channel/banked interfaces and return values in the testbench |
| `--testbench-style=verilog` with Verilator: array, scalar-port and `m_axi` interfaces, internal memory-mapped globals (weights, constants), several calls per testbench | Simulators other than Verilator |
| LLVM IR input with no C source: the testbench's own top function, or the IR compiled natively, is the reference model | XML test-vector input (`--generate-tb=<xml>`; untried) |
| soda-plugins dataflow designs (FIFOs between nodes), simulated and run under SST | The OpenROAD patch step for the generated Verilog |

## Why this branch exists

- `upstream/main` has not moved since April 2025; all development is on `dev/panda`.
- The soda-plugins dataflow lowering (the plugins are in soda-benchmarks, under
  `examples/soda-plugins`) needs two things only upstream `dev/panda` has: the `array_dims` parameter
  attribute in `--architecture-xml`, and the unified `ac_channel.h` (channel accesses are
  `_read_bambu_internal` / `_write_bambu_internal`, no nested `fifo` class).
- Upstream `dev/panda` replaced autotools with CMake and removed the C++ simulation framework, so the
  macOS/autotools work and the `--testbench-style=verilog` port on `feature/legacy-xml-testbench`
  do not carry over directly. That branch is the earlier pure-Verilog testbench port, on the
  autotools tree (upstream `main` plus the macOS commits); `legacy-xml` was this style's old
  name. The spike redid it on the CMake tree.

## Prerequisites

Built and tested on macOS 26 (arm64) with the Xcode command line tools and these Homebrew
packages: `llvm@19`, `cmake`, `ninja`, `boost`, `bison`, `flex`, `gmp`, `mpfr`, `verilator`,
`coreutils` and `gawk`. For SST runs also SST-Core 16.0 and verilator-sst (see soda-benchmarks).

Three choices are not interchangeable:

- **Apple clang builds Bambu; Homebrew `llvm@19` is the compiler Bambu drives**
  (`--compiler=I386_CLANG19`). Bambu loads clang plugins into that compiler, so the plugins must
  use the same C++ library (libc++); GCC's libstdc++ is ABI-incompatible with it. Do not use
  Homebrew GCC.
- **`~/SODA-OPT/llvm` (LLVM 19.1.5, the version soda-opt pins) cannot be used.** It is MLIR-only,
  static, has no clang, and has RTTI off. RTTI (run-time type information, the C++ support
  behind `dynamic_cast` and `typeid`) is needed by Bambu's clang plugins, whose classes derive
  from LLVM's, and LLVM is built without it by default.
- **Clang 19, the same major version as the LLVM that produced the IR.** Clang 16 is where this
  came from: it is the newest clang the earlier autotools Bambu supports (`I386_CLANG16` is the
  last compiler it knows; Homebrew `llvm@16`), so that was the clang used before upstream's `dev/panda`.
  LLVM does not promise that an older version reads newer IR, and soda-opt's LLVM 19 IR can use
  syntax that clang 16 does not know, so this branch uses clang 19 (`I386_CLANG19`).

## Build and install

```bash
brew install llvm@19
git clone -b spike/devpanda-macos-testbench git@github.com:tdysart/PandA-bambu.git
cd PandA-bambu && git submodule update --init --depth 1

export PATH=/opt/homebrew/opt/llvm@19/bin:$PATH
cmake -S . -B build -G Ninja \
  -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
  -DCMAKE_INSTALL_PREFIX=$HOME/bambu-devpanda \
  -DPANDA_ENABLE_WERROR=OFF -DPANDA_ENABLE_OPT=OFF \
  -DPANDA_LIBBAMBU_COMPILER=I386_CLANG19
ninja -C build && cmake --install build
```

The configure step should report `clang-19: OK`. Use a separate install prefix: the tool is
called `bambu` in every install, so keep installs apart on `PATH`. (On the maintainer's machine
the install is `~/SODA-OPT/panda/install-devpanda19`.)

## Running Bambu from the install

`settings.sh` and the backend scripts Bambu generates use GNU `readlink -e` and gawk (`xmlq` uses
gawk's three-argument `match()`). On macOS, set it up by hand (the soda-benchmarks scripts do
this for you):

```bash
I=$HOME/bambu-devpanda
mkdir -p /tmp/gnu-shim
ln -sf $(command -v greadlink) /tmp/gnu-shim/readlink     # from coreutils
ln -sf $(command -v gawk) /tmp/gnu-shim/awk
export BAMBU_HLS=$I BAMBU_HLS_BACKEND_PATH=$I
export PATH=/tmp/gnu-shim:$I/bin:/opt/homebrew/opt/llvm@19/bin:$PATH
export SDKROOT=$(xcrun --show-sdk-path)        # the Homebrew clang does not find the SDK itself
```

Then call `bambu` with `-m64` (no i386 or x32 targets on Darwin) and
`--compiler=I386_CLANG19`. Differences from the autotools Bambu that break copied command lines:

- `--soft-float`, `--verilator-parallel` and `-v3` are no longer options. `-lm` still is
  (`-l<m|m_s|m_newlib|m_musl>`, the math library) and LLVM IR that calls `sqrtf` needs it, or
  Bambu finds no functional unit for it. No libm variant has `roundevenf`.
- Interface pragmas use `#pragma HLS interface port=P0 mode=m_axi offset=direct bundle=gmem0`.
  The older `#pragma HLS_interface P0 m_axi direct` is silently ignored, which shows up as Bambu
  inferring a scalar interface and refusing the kernel ("pointer is written before it is read").
- Dataflow designs need `--generate-interface=INFER`. Without it Bambu defaults to minimal
  interface generation, forces every interface to `default`, and the `ac_channel` reads and
  writes are never turned into FIFO ports ("no functional unit ... `_read_bambu_internal`").

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
- BSD tool compatibility in the libtech data generation (`sed`, `head -n -N`), and in
  `append_libraries.sh` (a dropped closing tag corrupted the merged device files).
- `-msse2` is only passed on x86 hosts, and the simulation wrapper script no longer
  needs `date +%s.%N`.

## Pure-Verilog testbench: `--testbench-style=verilog`

This style is Bambu's original testbench: an HDL testbench driven by test vectors, with no host
process. It was the standard implementation up to the v2023.1 tag, before the DPI/C++ rework, and
it is what the verilator-sst flow needs.

```bash
bambu -m64 kernel.c --top-fname=kernel --compiler=I386_CLANG19 --device-name=nangate45 \
  --clock-period=5 --simulate --simulator=VERILATOR --testbench-style=verilog \
  --generate-interface=INFER --generate-tb=kernel_testbench.c
```

`--testbench-style` is `mdpi` (upstream's, the default) or `verilog`; `verilog` supports only
Verilator. No libmdpi, no host process, no ELF tooling, so it runs on macOS. How it works
(backend `etc/libtech/backend/simulation/verilator_verilog/`):

1. **Capture.** `launch.sh` compiles the user's testbench with a capture runtime
   (`capture/include/mdpi/mdpi_wrapper.h`) in place of libmdpi, and links it with the generated
   `mdpi_wrapper.cpp`, the reference (gold) build of the sources, and the testbench. It runs
   natively. At each call of the top function the wrapper records the memory the hardware will
   see in `tb_init.mem` and, after the reference run, the output in `tb_expected.mem`. The
   reference result is also copied back into the host arrays, so the testbench's own checks and
   later calls that read earlier outputs see correct data. The testbench's top function is made
   weak with `#pragma weak`, which replaces the ELF `objcopy` weakening that Mach-O cannot do.
2. **Replay.** The generated `bambu_testbench.v` is verilated with `BAMBU_TB_VERILOG`, which
   makes the library components import `tb_shim_pkg` (an in-simulation memory) instead of the
   five DPI functions (`NC_TESTBENCH_IPs.xml`). Before each run the shim loads that run's input
   image, and afterwards compares the memory with the expected image, printing each mismatch
   (`Sim: MISMATCH ...`).
3. **Results.** `bambu_time_simulation.txt` is converted to `bambu_results.xml`, so the stock
   `Evaluation` step reports cycles and executions, and the backend script exits with the
   simulation's status.

The testbench is a self-contained module with a single `clock` port, which is why it can run as
a verilator-sst custom module. Its `TestbenchFSM` final block runs once (`sim_ended`), because
`$finish` only raises a flag under Verilator and SST keeps clocking after it.

### What the C testbench has to look like

- It is the same file the MDPI flow uses: it calls the top function and may check the result.
- The top function may be defined in the same file as `main`.
- A pointer parameter whose type does not give its size (`void*`) needs
  `m_param_alloc(index, bytes)` before the call, as for the MDPI flow
  (`#ifdef __BAMBU_SIM__ #include <mdpi/mdpi_user.h>`). Without it the capture only knows the
  wrapper's 4-byte placeholder.
- **The reference model.** With C sources, the design's own source, with the top function
  renamed, is the reference. With LLVM IR sources there is no C to run, so `launch.sh` uses the
  testbench file's own definition of the top function if it has one, and otherwise compiles the
  IR natively, with the top function renamed, as the reference (this checks the hardware against
  the IR, not against the model the IR came from). Dataflow designs from soda-plugins need the
  first form: their `ac_channel` operations only exist in hardware, so the IR cannot run.

### Images and interfaces

- The image files hold `w` records (element-addressed words and scalar ports) and `m` records
  (byte-addressed memory, at most 64 bytes each); see `capture/include/mdpi/mdpi_wrapper.h`.
- `m_axi` pointer parameters: the capture maps each host buffer at a device address (as the
  wrapper's `__m_memmap` does), records the address as the pointer port's value and the buffer
  in the byte-addressed memory, and the shim serves reads and writes of any width at any byte
  address (little endian).
- Memory-mapped internal variables (constants such as weights, initialized globals) are mapped
  by the wrapper like the pointer parameters but belong to no parameter; the capture writes the
  ones left over into `tb_init.mem` (`__m_dump_internal_regions`). Before this was added the
  hardware ran with them zeroed.
- Not supported yet (the capture stops with a clear error where it can tell): top-level
  FIFO/AXIS, channel and banked interfaces, and return values. FIFOs between dataflow modules
  inside the design are hardware and are not affected. The shim keeps its images in associative
  arrays and scans them per run, which is fine for kernels of tens of millions of cycles but
  will be slow for very large memories.

### Dataflow designs from LLVM IR

The soda-plugins `forward` design (three nodes joined by FIFOs, `D = 0.5*(A*B) + 0.1f*C`) runs in
this testbench: 1849 cycles, all 32 output words bit-exact against the reference model, and a
one-ulp corruption of the expected image is detected. The plugin must be told the word size of
the machine it targets: use `machine-bits=64` on `sodap-dataflow-to-llvm-pipeline` with
`bambu -m64`; its default, `-m32`, has no sysroot on arm64 macOS. Pass `--generate-interface=INFER`.

### Regression

`panda_regressions/hls/bambu_verilog_testbench/run.sh [install_dir]` synthesizes and replays four
cases (`vadd`, a testbench with three calls including one that consumes an earlier output, an
`m_axi` kernel with two calls, and the dataflow `forward`), then corrupts one expected word of
each and checks that the failure is reported and the return code is 1. It sets up the GNU shims
itself and needs the install, Verilator and `llvm@19`.

The soda-plugins' own tests (`check-sodap`) skip the Bambu-dependent cases (`REQUIRES: panda`)
here: they need `SODAP_BAMBU_ROOT`, whose defaults assume a `compilers/clang-19` directory and
the plugin's 32-bit target. The `machine-bits` option was checked by hand.

## Known limitation: the MDPI simulation path does not run on macOS

**Decision (2026-10-07): not fixing this now.** The pure-Verilog testbench does not use libmdpi,
so this is off the critical path. Revisit it if upstream's own `--simulate` flow is needed on
macOS.

With `--simulate --simulator=VERILATOR --generate-tb=<c file with main>`, a small C vector-add
kernel synthesizes to Verilog and the generated simulation scripts start. The failures, in
order, and their status:

1. **GNU tools assumed by the generated scripts** (`readlink -e`, gawk's `match()`). Worked
   around by the shims above. Not changed in the repo.
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

macOS has no GNU `objcopy`. On the maintainer's machine `objcopy` resolves to
`~/.local/bin/objcopy`, a shim to Homebrew `llvm@16`'s `llvm-objcopy` (16.0.6), which fails the
Makefile with "option is not supported for MachO" on `--weaken`. `llvm-objcopy` from `llvm@19`
was tried directly on a Mach-O object:

- `--redefine-sym` works, but names need the leading underscore (`_top=__m_top`).
- `--weaken`, `-W` and `--weaken-symbol` are accepted but **do nothing**, so the testbench's
  own `top` stays a strong symbol and cannot be overridden by the DPI wrapper's `top`.

Other Linux-isms in the same Makefile, not yet reached: `-Wl,-z,defs`, `-Bsymbolic`,
`-D_GNU_SOURCE`, `-ldl`, `realpath --relative-to`, and the `get_pc_thunk` symbol handling. The
`mdpi_driver`/`mdpi_ipc*` sources also carry Darwin changes on the autotools branch
(`feature/legacy-xml-testbench`: `mdpi_ipc_sig.h`, `mdpi_types.h`, `mdpi_driver.cpp`) that would
have to be redone against the rewritten `etc/libmdpi`.

### If we pick this up later

- Replace the weakening with something Mach-O can express: compile the testbench with the top
  function marked `__attribute__((weak))` (the verilog style does this with `-include` of a
  `#pragma weak`), or link the DPI wrapper first with `-Wl,-multiply_defined,suppress`, or rename
  the symbol in the C front end instead of post-processing.
- Do the `--redefine-sym` renames with `llvm-objcopy` and a `_` prefix on Mach-O.
- Port the Darwin changes from the autotools branch's libmdpi onto `etc/libmdpi`.
- Make the generated scripts portable (`readlink -e`, gawk-only `xmlq`) instead of shimming.

## Troubleshooting

- **`clang-19: command not found`.** Put `/opt/homebrew/opt/llvm@19/bin` on `PATH`.
- **`stdio.h` not found while Bambu compiles.** Export `SDKROOT=$(xcrun --show-sdk-path)`.
- **`readlink: illegal option -- e` or an awk syntax error in `xmlq`.** The GNU shims are
  missing (see "Running Bambu from the install").
- **`unrecognized option '--soft-float'` (or `-v3`).** Dropped in upstream `dev/panda`, and so here; remove them.
- **`uses inferred scalar pointer interface 'ovalid' but the pointer is written before it is
  read`.** The interface pragmas are in the old syntax; use `#pragma HLS interface port=...`.
- **`syntax error ... Error in parsing xml ... asap7-BC.spec_data`.** The device files were
  merged by an older `etc/scripts/append_libraries.sh` that dropped a closing tag on macOS.
  Rebuild from this branch.
- **The soda-plugins pass fails compiling the specialization unit (`ldiv_t`, `mbstate_t` not
  found).** It compiled for a 32-bit ARM target; pass `machine-bits=64`.
- **`capture: ... is not supported by the verilog testbench style`.** The top function uses an
  interface the capture cannot record yet (FIFO/AXIS, channels, return values, banked). The
  message names it.
- **A pointer parameter's buffer is cut short in the images, or the replay mismatches on a
  `void*` parameter.** Add `m_param_alloc(N, bytes)` for it to the testbench.
- **`no functional unit ... roundevenf`.** No libm variant has it; provide a definition in the
  IR (soda-benchmarks links one for `llvm.roundeven`).
- **`error -> not expected from S_<n> to S_<m>`.** An internal error of the `-MP` setups
  (`--experimental-setup=BAMBU-BALANCED-MP`) on large designs; the same design goes through with
  `BAMBU-BALANCED`.
- **A simulation that never finishes ("Simulation exceeds 200000000 cycles").** Check the heap
  before anything else. Bambu's `malloc` (`etc/libbambu/memmgr.c`, synthesized into the design)
  has a fixed 384 KiB pool, `POOL_SIZE`, compiled into `libbambu.a`; when it is exhausted it
  returns NULL silently and the design runs on with a null pointer until the cycle cap. IR that
  `malloc`s more than that without freeing (soda-opt's, unless its buffers are freed early) will
  not run. soda-benchmarks' `docs/FlowSurvey.md` has the investigation.
- **Installing over an existing Bambu.** Use a separate `CMAKE_INSTALL_PREFIX`.

## Maintaining the branch

The branch is a handful of commits on top of `upstream/dev/panda` (`git log
upstream/dev/panda..HEAD`): the macOS portability fixes (CMake, libc++ source fixes, glibc-isms in
libbambu, BSD tool differences), then the testbench style (`BambuParameter.cpp`,
`NC_TESTBENCH_IPs.xml`, the `verilator_verilog` backend directory) and the regression. To follow
upstream, rebase onto `upstream/dev/panda`; the places most likely to conflict are the CMake files
and `NC_TESTBENCH_IPs.xml`. The branch is rebased, not merged, so its history is rewritten on each
sync: push it with `git push --force-with-lease`, and keep a local backup branch of the old tip
first. After a rebase, rebuild, re-run the regression, and run the soda-benchmarks examples
through SST (the C `3mm` and the PyTorch `3mm-no_weights`; their cycle counts are in soda-benchmarks'
`docs/FlowSurvey.md`).
