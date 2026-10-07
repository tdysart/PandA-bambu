#!/usr/bin/env bash
#######################################################################
# Verilator backend for --testbench-style=verilog.
#
# Runs the generated testbench without the MDPI/DPI host:
#   1. capture : the user's testbench is compiled with the capture runtime
#                (capture/include/mdpi/mdpi_wrapper.h) in place of libmdpi and run natively.
#                It records the memory image at every call of the top function
#                (tb_init.mem) and the reference result (tb_expected.mem).
#   2. simulate: the generated bambu_testbench.v is verilated with BAMBU_TB_VERILOG, which
#                swaps the DPI imports for tb_shim_pkg: an in-simulation memory loaded from
#                the images, checked against the expected images after each run.
#   3. results : bambu_time_simulation.txt is converted to bambu_results.xml.
#######################################################################
SWD=`dirname $(readlink -e $0)`
OUT_LVL="$(bambu_results /application@verbosity)"
set -e

if command -v verilator 2>&1 > /dev/null; then
  VERILATOR_ROOT=`dirname $(dirname $(command -v verilator))`
else
  VERILATOR_BIN=`dirname $(find -L ${BAMBU_HLS_BACKEND_PATH//:/ } \( -type f -o -type l \) -path "*/bin/verilator" 2> /dev/null | head -n1) 2> /dev/null`
  VERILATOR_ROOT=`dirname ${VERILATOR_BIN}`
  export PATH="${VERILATOR_BIN}:${PATH}"
fi
if [ -z "${VERILATOR_ROOT}" ]; then
  echo "Verilator executable not found"
  exit 1
fi
echo "Verilator root path: ${VERILATOR_ROOT}"

SIM_DIR="HLS_output/simulation"
CAP_DIR="${SWD}/capture_build"
WORK_DIR="${SWD}/work"
mkdir -p "${CAP_DIR}" "${WORK_DIR}"

#######################################################################
###  1. Capture the memory images by running the user's testbench natively
#######################################################################
CC="$(bambu_results /application/sources@compiler)"
CFLAGS="$(echo $(bambu_results /application/sources@cflags) | envsubst)"
CFLAGS+=" -fwrapv -fno-strict-aliasing -D__BAMBU_SIM__"
CFLAGS+=" -D__builtin_bambu_time_start\(\)= -D__builtin_bambu_time_stop\(\)="
TB_CFLAGS="$(bambu_results /application/testbench@cflags)"
TOP="$(bambu_results /application/testbench@symbol)"
MTOP="$(bambu_results /application/testbench@m_symbol)"
SRCS="$(bambu_results /application/sources/file)"
TB_SRCS="$(bambu_results /application/testbench/file)"

# The testbench defines (or declares) the top function and calls it; the generated wrapper
# provides the strong definition that records the images. Marking the testbench's own copy
# weak lets the wrapper win at link time without ELF-only objcopy.
printf '#pragma weak %s\n' "${TOP}" > "${CAP_DIR}/weak_top.h"

# The reference implementation is the design's own source, with the top function renamed to
# its gold name and any main renamed away. When the design comes from LLVM IR there is no C
# to run natively (and, for a dataflow design, no host ac_channel), so the testbench file's
# own definition of the top function is the reference model instead.
GOLD_SRCS=""
for src in ${SRCS}; do
  case "${src}" in *.ll|*.bc) ;; *) GOLD_SRCS+=" ${src}" ;; esac
done
if [ -z "${GOLD_SRCS}" ]; then
  echo "Sim: Design sources are LLVM IR: the testbench's '${TOP}' is the reference model"
  GOLD_SRCS="${TB_SRCS}"
fi

OBJS=()
i=0
for src in ${GOLD_SRCS}; do
  obj="${CAP_DIR}/gold_${i}.o"; i=$((i+1))
  ${CC} ${CFLAGS} -D${TOP}=${MTOP} -Dmain=__m_gold_main_${i} -c "${src}" -o "${obj}"
  OBJS+=("${obj}")
done
for src in ${TB_SRCS}; do   # user testbench: calls the top function
  obj="${CAP_DIR}/tb_${i}.o"; i=$((i+1))
  ${CC} ${CFLAGS} ${TB_CFLAGS} -include "${CAP_DIR}/weak_top.h" -c "${src}" -o "${obj}"
  OBJS+=("${obj}")
done
# the generated wrapper is C++ with the macros of the capture runtime
WRAP_CFLAGS="$(echo "${CFLAGS}" | sed -E 's/(-{1,2}std=(c|gnu)([0-9]+|\+\+(0|9)([0-9]|x)))//g')"
${CC} ${WRAP_CFLAGS} -std=c++14 -fno-exceptions -I"${SWD}/capture/include" -c "${SIM_DIR}/mdpi_wrapper.cpp" \
  -o "${CAP_DIR}/wrapper.o"
OBJS+=("${CAP_DIR}/wrapper.o")

LINK_FLAGS="-lm"
if basename "${CC}" | grep -v '++' | grep -q 'clang'; then LINK_FLAGS+=" --driver-mode=g++"; else LINK_FLAGS+=" -lstdc++"; fi
${CC} -o "${CAP_DIR}/capture" "${OBJS[@]}" ${LINK_FLAGS}

echo "Sim: Capturing memory images"
CAP_RUN="${CAP_DIR}/run"
rm -rf "${CAP_RUN}"; mkdir -p "${CAP_RUN}"
# the images are written to the working directory of the capture run
(cd "${CAP_RUN}" && "${CAP_DIR}/capture" "$@") 2>&1 | tee "${CAP_DIR}/capture.log"
if [ ${PIPESTATUS[0]} -ne 0 ]; then
  echo "Sim: ERROR: the testbench failed when run natively; see ${CAP_DIR}/capture.log" 1>&2
  exit 1
fi
if [ ! -s "${CAP_RUN}/tb_init.mem" ] || [ ! -s "${CAP_RUN}/tb_expected.mem" ]; then
  echo "Sim: ERROR: the testbench never called the top function '${TOP}'" 1>&2
  exit 1
fi

#######################################################################
###  2. Verilate and run the DPI-free testbench
#######################################################################
VERILATOR_VERSION="$({ verilator --version 2>/dev/null || echo 0; } | sed -E 's/Verilator ([0-9]+).*/\1/')"

VFLAGS="+define+BAMBU_TB_VERILOG"
case "$(bambu_results /application/sources@cflags)" in
  *-m32*) VFLAGS+=" +define+__M32" ;;
  *-mx32*) VFLAGS+=" +define+__MX32" ;;
  *) VFLAGS+=" +define+__M64" ;;
esac
if [ "x$(bambu_results /application/backend@vcd)" != "x" ]; then
  VFLAGS+=" +define+GENERATE_VCD"
fi
if $(bambu_results /application/backend@discrepancy) ; then
  VFLAGS+=" +define+GENERATE_VCD_DISCREPANCY"
fi
VFLAGS+=" +define+__BAMBU_SIM__"
for inc in $(bambu_results /application/outputs/include)
do
  VFLAGS+=" +incdir+${inc}"
done

ln -sf "${BAMBU_HLS_OUTDIR}/HLS_output" "${WORK_DIR}/HLS_output" || true

OPT="-fstrict-aliasing"
OPT+=" -DCLOCK_PORT_NAME=$(bambu_results /application/top_module@clock_name)"

VPPFLAGS="--cc --exe --Mdir ${WORK_DIR}"
VPPFLAGS+=" -Wno-fatal -Wno-lint"
VPPFLAGS+=" -O3 --unroll-count 10000 --output-split-cfuncs 3000 --output-split-ctrace 3000"
VPPFLAGS+=" -sv ${VFLAGS}"
if [ "x$(bambu_results /application/backend@vcd)" != "x" ]; then
  VPPFLAGS+=" --trace --trace-underscore"
  OPT+=" -DVCD_OUT_FILENAME=\\\"$(bambu_results /application/backend@vcd)\\\""
else
  VPPFLAGS+=" --x-assign fast --x-initial fast --noassert"
fi
if test ${VERILATOR_VERSION} -ge 5; then
  VPPFLAGS+=" --no-timing"
fi
VPPTHREADS="$(bambu_results /application/backend@parallel)"
if [ "${VPPTHREADS}" != "1" ] && test ${VERILATOR_VERSION} -ge 4; then
  VPPFLAGS+=" --threads ${VPPTHREADS}"
fi
VPPFLAGS+=" --top-module bambu_testbench"

verilator ${VPPFLAGS} "${SWD}/bambu_testbench.cpp" \
  "${SWD}/tb_shim_pkg.sv" \
  $(bambu_results /application/outputs/file) \
  $(bambu_results /application/outputs/testbench)

make -C "${WORK_DIR}" -j "${VPPTHREADS}" OPT="${OPT}" -f Vbambu_testbench.mk Vbambu_testbench

# The testbench opens the images and the result file relative to its working directory.
cp "${CAP_RUN}/tb_init.mem" "${CAP_RUN}/tb_expected.mem" .
echo "Sim: Launch Verilated testbench"
set +e
"${WORK_DIR}/Vbambu_testbench" 2>&1 | tee "${SWD}/simulation.log"
sim_status=${PIPESTATUS[0]}
set -e

#######################################################################
###  3. Results
#######################################################################
convert_results() {
  awk 'NR==1{n=split($0,x,/,/);for(i=1;i<=n;i++){gsub(/^[ \t\r\n]+|[ \t\r\n]+$/,"",x[i]);if(x[i]=="")continue;split(x[i],p,/\|/);a=p[1];b=p[2];if(b=="A"||b=="X"){r[++c]=b}else{v=(b-a)/2;r[++c]=(v==int(v)?int(v):v)}}}
  NR==2{rv=$0;gsub(/^[ \t\r\n]+|[ \t\r\n]+$/,"",rv);if(rv=="")rv="A"}
  END{if(rv=="")rv="A";printf"<application><timing><simulation return_value=\"%s\">",rv;for(i=1;i<=c;i++)printf"<run>%s</run>",r[i];print"</simulation></timing></application>"}' "$1"
}
convert_results bambu_time_simulation.txt > "${SWD}/bambu_results.xml"
exit ${sim_status}
