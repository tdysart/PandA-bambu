#!/usr/bin/env bash
# Regression for --testbench-style=verilog (Verilator, no DPI host).
#
#   ./run.sh [install_dir]
#
# For each testbench: synthesize, run it natively to record the memory images, replay them in
# the Verilated Verilog testbench, and check the reported mismatches and cycle counts. Then
# corrupt one expected word and check that the failure is detected.
#
# Needs a dev/panda Bambu install, Verilator, and a clang matching the install's compiler
# (--compiler). On macOS also Homebrew coreutils and gawk: the generated backend scripts use
# GNU readlink -e and gawk (see MACOS_PORT.md); shims are set up below when they are present.
set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
I="${1:-${BAMBU_HLS:-$HOME/SODA-OPT/panda/install-devpanda19}}"
COMPILER="${COMPILER:-I386_CLANG19}"
WORK="${WORK:-$(mktemp -d)}"
mkdir -p "$WORK"
export BAMBU_HLS="$I" BAMBU_HLS_BACKEND_PATH="$I"
export PATH="$I/bin:/opt/homebrew/opt/llvm@19/bin:$PATH"
SHIM="$WORK/gnu-shim"; mkdir -p "$SHIM"
command -v greadlink > /dev/null && ln -sf "$(command -v greadlink)" "$SHIM/readlink"
command -v gawk > /dev/null && ln -sf "$(command -v gawk)" "$SHIM/awk"
export PATH="$SHIM:$PATH"

fail=0
check() { # description, command...
  local what="$1"; shift
  if "$@"; then echo "  ok   $what"; else echo "  FAIL $what"; fail=1; fi
}

run_case() { # name, expected runs
  local name="$1" runs="$2" dir="$WORK/$1"
  rm -rf "$dir"; mkdir -p "$dir"; cd "$dir"
  cp "$HERE/$name.c" k.c
  echo "== $name"
  bambu -m64 k.c --top-fname=vadd --compiler="$COMPILER" --device-name=nangate45 \
    --clock-period=5 --simulate --simulator=VERILATOR --testbench-style=verilog \
    --generate-interface=INFER --generate-tb=k.c > bambu.log 2>&1
  local rc=$?
  local B=HLS_output/simulation/verilator_verilog_backend
  check "bambu exits 0" test $rc -eq 0
  check "$runs run(s) replayed, no mismatches" \
    grep -q "Sim: $runs run(s) checked, 0 mismatching word(s)" "$B/simulation.log"
  check "$runs execution(s) reported" grep -q "Number of executions     : $runs" bambu.log
  check "results file has return_value=0" grep -q 'return_value="0"' "$B/bambu_results.xml"

  # Corrupt the first expected word of the last run and replay: must fail.
  local last=$((runs - 1))
  awk -v r="$last" '!done && $1==r {$4="00ff00ff"; done=1} {print}' tb_expected.mem > t && mv t tb_expected.mem
  ./"$B"/work/Vbambu_testbench > bad.log 2>&1
  check "corrupted expectation is reported" grep -q "MISMATCH run=$last" bad.log
  check "failure return code is 1" grep -q '^1$' bambu_time_simulation.txt
}

run_case vadd 1
run_case vadd_multi 3
echo "work dir: $WORK"
exit $fail
