#!/usr/bin/env bash
# Prototype: run the Bambu-generated vadd testbench with no DPI/libmdpi host.
#
#   ./run.sh [install_dir]
#
# Needs: a dev/panda Bambu install (default ~/SODA-OPT/panda/install-devpanda19),
# Homebrew llvm@19, coreutils and gawk (the generated backend scripts use GNU
# readlink -e and gawk, see MACOS_PORT.md), and Verilator.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
I="${1:-$HOME/SODA-OPT/panda/install-devpanda19}"
WORK="${WORK:-$(mktemp -d)}"
mkdir -p "$WORK"
export BAMBU_HLS="$I" BAMBU_HLS_BACKEND_PATH="$I"
export PATH="$I/bin:/opt/homebrew/opt/llvm@19/bin:$PATH"

# GNU readlink/awk shims, only needed where the system tools are the BSD ones.
SHIM="$WORK/gnu-shim"
mkdir -p "$SHIM"
command -v greadlink > /dev/null && ln -sf "$(command -v greadlink)" "$SHIM/readlink"
command -v gawk > /dev/null && ln -sf "$(command -v gawk)" "$SHIM/awk"
export PATH="$SHIM:$PATH"

cd "$WORK"
cp "$HERE"/vadd/k.c .
# 1. Let Bambu synthesize and generate the structural testbench. The simulation
#    step itself fails on macOS (MDPI, see MACOS_PORT.md); only the generated
#    files are used here.
bambu -m64 k.c --top-fname=vadd --compiler=I386_CLANG19 --device-name=nangate45 \
  --clock-period=5 --simulate --simulator=VERILATOR --generate-interface=INFER \
  --generate-tb=k.c > bambu.log 2>&1 || true
TB=HLS_output/simulation/bambu_testbench.v
test -f "$TB" || { echo "no testbench generated, see $WORK/bambu.log"; exit 1; }

# 2. Replace the five DPI imports with the in-simulation shim.
python3 "$HERE/nodpi.py" "$TB" bambu_testbench_nodpi.v
cp "$HERE"/tb_shim_pkg.sv "$HERE"/vadd/tb_init.mem "$HERE"/vadd/tb_expected.mem .
cp HLS_output/simulation/verilator_backend/bambu_testbench.cpp .

# 3. Verilate and run, as the stock Verilator backend does minus libmdpi.
verilator --cc --exe --Mdir work -Wno-fatal -Wno-lint -O3 --unroll-count 10000 \
  --output-split-cfuncs 3000 -sv +define+__M64 +define+__BAMBU_SIM__ \
  --x-assign fast --x-initial fast --noassert --no-timing --top-module bambu_testbench \
  -CFLAGS "-DCLOCK_PORT_NAME=clock" bambu_testbench.cpp tb_shim_pkg.sv \
  vadd.v panda_libtech.v bambu_testbench_nodpi.v > verilator.log 2>&1
make -C work -j8 OPT="-fstrict-aliasing -DCLOCK_PORT_NAME=clock" \
  -f Vbambu_testbench.mk Vbambu_testbench > make.log 2>&1
./work/Vbambu_testbench
echo "--- bambu_time_simulation.txt (start|end, then return code):"
cat bambu_time_simulation.txt
echo "work dir: $WORK"
