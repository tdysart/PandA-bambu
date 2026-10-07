# Dataflow `forward` design

`forward.ll` and `architecture.xml.in` are the output of the soda-plugins backend for
`examples/soda-plugins/test/sodap/Conversion/DataflowToLLVM/Inputs/gemm_small.mlir`
(three dataflow nodes joined by FIFOs: `D = 0.5 * (A * B) + 0.1f * C`), generated with:

```bash
mlir-opt gemm_small.mlir \
  --load-dialect-plugin=SODAPlugin.so --load-pass-plugin=SODAPlugin.so \
  --pass-pipeline="builtin.module(sodap-dataflow-to-llvm-pipeline{top-func=forward arch-file=architecture.xml \
      clangxx=<clang++-19> include-panda-path=<bambu>/include/panda machine-bits=64})"
mlir-translate --mlir-to-llvmir llvm.mlir -o kernel.ll
llvm-link -S kernel.ll ac_channel_specializations.ll -o linked.ll
opt linked.ll -passes=always-inline -S -o forward.ll
```

`machine-bits=64` matches Bambu's `-m64` (there is no 32-bit target on arm64 macOS).
`@PANDA_INCLUDE@` in the XML is replaced with the Bambu include directory by `../run.sh`.

`forward_tb.c` is the testbench; its `forward` is the single-precision reference model that
the hardware result is compared against (bit exact, no fused multiply-add).
