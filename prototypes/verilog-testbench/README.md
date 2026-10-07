# Pure-Verilog (DPI-free) testbench prototype

Feasibility prototype for `--testbench-style=verilog` on `dev/panda`.

## Idea

The `dev/panda` HDL testbench is structural: Bambu emits one `bambu_testbench.v` built from
library components (`TestbenchFSM`, `TestbenchArrayImpl`, `TestbenchMEMMinimal`, the
`if_*` interface wrappers, ...). All host interaction goes through **five DPI imports**:

| Import | Used by | Meaning |
|--------|---------|---------|
| `m_next(state)` | `TestbenchFSM` | what to do next (run, or end); return code in bits [15:8] |
| `m_fini()` | `TestbenchFSM` | end of simulation; return code in bits [15:8] |
| `m_read(id, data, bitsize, addr, cmd)` | `if_utils` | read for interface `id`; `cmd` 0 = read, 1 = pop |
| `m_write(id, data, bitsize, addr, cmd)` | `if_utils` | write; `cmd` 0 = write, -1 = push |
| `m_state(id, data)` | `if_utils` | FIFO space/state query |

Normally a C program on the host answers them over IPC (libmdpi). Here they are replaced by
SystemVerilog functions in `tb_shim_pkg` that keep an associative-array memory keyed by
`{interface id, address}`, loaded from `tb_init.mem` and checked against `tb_expected.mem`
in `m_fini`. `nodpi.py` rewrites the five `import "DPI-C"` lines of the generated file to
`import tb_shim_pkg::...`; nothing else in the generated testbench changes.

## Result (vadd, 2026-10-07)

`./run.sh` builds the design with Bambu, rewrites the testbench, verilates it without
libmdpi, and runs it on macOS arm64:

```
Sim: 8 expected words checked, 0 mismatches
Sim: Driver terminated with code: 0
7|31,
0
```

- The file format matches what `convert_results` in `simulation_wrapper.sh` parses, so the
  stock `Evaluation` step could consume it unchanged.
- A deliberately wrong expected word is reported (`expected=99 got=21`) and the return code
  becomes 1.

## Not covered yet

- **Value and layout generation.** `tb_init.mem`/`tb_expected.mem` are written by hand here.
  Bambu has to produce them from the XML test vectors (`TestVectorParser`) and the golden
  result, which the host computed in the DPI flow (compile and run the C function natively;
  the autotools port did this in `verilog_testbench_expected_values.cpp`).
- **Address model.** Array interfaces are element-addressed per interface `id`, which the
  shim mirrors. Byte-addressed `TestbenchMEMMinimal` (external memory, `base_addr`) and
  partial-width writes (`write_strobe`) need a byte-granular model.
- **Scalar and handshake interfaces.** `read()` (address 0) works as a per-id value, but
  return-value capture, `none`/`valid`/`handshake` protocols are untested.
- **Top-level FIFO ports.** `pop`/`push`/`m_state` return capacity/availability codes the
  shim does not model (internal dataflow FIFOs are hardware and are unaffected).
- **Multiple runs.** `N_RUNS` is fixed at 1; several test vectors need memory re-initialised
  between runs.
- **Integration.** The imports are literal text in `etc/libtech/NC_TESTBENCH_IPs.xml`, so
  the style has to be selectable (a `` `ifdef `` or a generated include), plus a Verilator
  backend directory that skips libmdpi.
