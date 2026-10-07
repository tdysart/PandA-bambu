# macOS (arm64) port of `dev/panda`

Status notes for the `spike/devpanda-macos-testbench` branch, which builds upstream
`dev/panda` natively on macOS/arm64. Last updated 2026-10-07.

## Why this branch exists

- `upstream/main` has not moved since April 2025; all development is on `dev/panda`.
- The soda-plugins dataflow lowering needs two things only `dev/panda` has: the
  `array_dims` parameter attribute in `--architecture-xml`, and the unified
  `ac_channel.h` (channel accesses are `_read_bambu_internal` / `_write_bambu_internal`,
  no nested `fifo` class).
- `dev/panda` replaced autotools with CMake and removed the C++ simulation framework, so the
  macOS/autotools work and the `--testbench-style=verilog` port on
  `feature/legacy-xml-testbench` do not carry over directly.

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
- `~/SODA-OPT/llvm` cannot be used: it is MLIR-only, static, RTTI off, and has no clang.
- Clang 16 cannot read the LLVM 19 IR that soda-opt produces (opaque pointers), so the
  clang Bambu uses must be the same major version as the LLVM that produced the IR.

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

## Next: the pure-Verilog testbench

Add `--testbench-style=verilog` as another HDL testbench step alongside
`HDLTestbenchGeneration`, reusing the generator logic from
`feature/legacy-xml-testbench` (`verilog_testbench_*`). That path needs no libmdpi. The
2024-era simulation classes it was built on (`SimulationTool`,
`generate_simulation_scripts`, `compute_reserved_memory`, `memory_initialization_writer*`)
were deleted by upstream's refactor (#388), so it has to be rewired to the `evaluation`
step and the new IR helper names, not applied as a patch.
