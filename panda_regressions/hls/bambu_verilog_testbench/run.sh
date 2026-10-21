#!/usr/bin/env bash
# Regression for --testbench-style=verilog (Verilator, no DPI host).
#
#   ./run.sh [install_dir]
#
# For each testbench: synthesize, run it natively to record the memory images, replay them in
# the Verilated Verilog testbench, and check the reported mismatches and cycle counts. Then
# corrupt one expected word and check that the failure is detected. The dataflow case
# synthesizes the soda-plugins `forward` design (FIFOs between three nodes).
#
# Needs an install of the bambu branch (see MACOS_PORT.md), Verilator, and a clang matching the
# install's compiler (--compiler); CLANG_BIN says where it is. On macOS also Homebrew coreutils and gawk: the generated backend scripts use
# GNU readlink -e and gawk (see MACOS_PORT.md); shims are set up below when they are present.
set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
I="${1:-${BAMBU_HLS:-$HOME/SODA-OPT/panda/install-devpanda-llvm-full}}"
COMPILER="${COMPILER:-I386_CLANG19}"
WORK="${WORK:-$(mktemp -d)}"
mkdir -p "$WORK"
export BAMBU_HLS="$I" BAMBU_HLS_BACKEND_PATH="$I"
# CLANG_BIN, when set, is the directory of the clang named by --compiler; otherwise clang-19 has to
# be on PATH already (see MACOS_PORT.md).
export PATH="$I/bin:${CLANG_BIN:+$CLANG_BIN:}$PATH"
command -v clang-19 > /dev/null || { echo "clang-19 not found on PATH (set CLANG_BIN)" >&2; exit 2; }
# A clang that is not Apple's does not find the macOS SDK on its own.
[ "$(uname)" = "Darwin" ] && export SDKROOT="${SDKROOT:-$(xcrun --show-sdk-path)}"
SHIM="$WORK/gnu-shim"; mkdir -p "$SHIM"
command -v greadlink > /dev/null && ln -sf "$(command -v greadlink)" "$SHIM/readlink"
command -v gawk > /dev/null && ln -sf "$(command -v gawk)" "$SHIM/awk"
export PATH="$SHIM:$PATH"

fail=0
check() { # description, command...
  local what="$1"; shift
  if "$@"; then echo "  ok   $what"; else echo "  FAIL $what"; fail=1; fi
}

run_case() { # name, expected runs, kind (c | dataflow)
  local name="$1" runs="$2" kind="${3:-c}" dir="$WORK/$1"
  rm -rf "$dir"; mkdir -p "$dir"; cd "$dir"
  echo "== $name"
  local rc
  if [ "$kind" = dataflow ]; then
    # LLVM IR from the soda-plugins backend plus its architecture XML; the testbench's own
    # `forward` is the reference model.
    cp "$HERE/dataflow_forward/forward.ll" "$HERE/dataflow_forward/forward_tb.c" .
    sed "s#@PANDA_INCLUDE@#$I/include/panda#g" "$HERE/dataflow_forward/architecture.xml.in" > architecture.xml
    bambu -m64 forward.ll --top-fname=forward --architecture-xml=architecture.xml \
      --compiler="$COMPILER" --device-name=nangate45 --clock-period=5 --simulate \
      --simulator=VERILATOR --testbench-style=verilog --generate-interface=INFER \
      --generate-tb=forward_tb.c > bambu.log 2>&1
    rc=$?
  else
    cp "$HERE/$name.c" k.c
    bambu -m64 k.c --top-fname=vadd --compiler="$COMPILER" --device-name=nangate45 \
      --clock-period=5 --simulate --simulator=VERILATOR --testbench-style=verilog \
      --generate-interface=INFER --generate-tb=k.c > bambu.log 2>&1
    rc=$?
  fi
  local B=HLS_output/simulation/verilator_verilog_backend
  check "bambu exits 0" test $rc -eq 0
  check "$runs run(s) replayed, no mismatches" \
    grep -q "Sim: $runs run(s) checked, 0 mismatching word(s)" "$B/simulation.log"
  check "$runs execution(s) reported" grep -q "Number of executions     : $runs" bambu.log
  check "results file has return_value=0" grep -q 'return_value="0"' "$B/bambu_results.xml"

  # Corrupt the first expected word of the last run and replay: must fail.
  local last=$((runs - 1))
  # corrupt the first record of the last run, whichever kind (w: word data, m: byte data)
  awk -v r="$last" '!done && $2==r {$NF = ($1=="m") ? "ff" substr($NF, 3) : "00ff00ff"; done=1} {print}' tb_expected.mem > t && mv t tb_expected.mem
  ./"$B"/work/Vbambu_testbench > bad.log 2>&1
  check "corrupted expectation is reported" grep -q "MISMATCH run=$last" bad.log
  check "failure return code is 1" grep -q '^1$' bambu_time_simulation.txt
}

run_case vadd 1
run_case vadd_multi 3
run_case vadd_axi 2
run_case dataflow_forward 1 dataflow
echo "work dir: $WORK"
exit $fail
