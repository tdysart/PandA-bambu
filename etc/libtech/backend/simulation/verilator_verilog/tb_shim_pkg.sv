// DPI-free replacement for the libmdpi host interface used by the Bambu testbench components
// (selected by defining BAMBU_TB_VERILOG, see NC_TESTBENCH_IPs.xml).
//
// The host process that normally answers the DPI calls is replaced by an in-simulation memory
// model. It is loaded, one run at a time, from tb_init.mem and each run is checked against
// tb_expected.mem when it ends. Both files hold one record per line, written by the capture
// step of the verilator_verilog backend (capture/include/mdpi/mdpi_wrapper.h):
//
//   w <run> <interface id> <element address> <data>            array element or scalar port
//   m <run> <memory id> <byte address> <byte count> <data>     byte-addressed memory (m_axi)
//
// Numbers are decimal for run, id and byte count, hexadecimal for addresses and data. The ids
// that have `m` records are byte-addressed (a read or write of `bitsize` bits at a byte
// address, little endian); all others are element-addressed words.
package tb_shim_pkg;
  localparam int unsigned STATE_SETUP = 7'b0000010;
  localparam int unsigned STATE_END   = 7'b0001000;

  typedef bit [4095:0] word_t;

  // Current run
  word_t      mem  [longint unsigned];  // element-addressed words, key(id, addr)
  bit [7:0]   bmem [longint unsigned];  // byte-addressed memory,   key(id, byte addr)
  // All runs, ikey(run, id, addr)
  word_t      init_w [longint unsigned];
  word_t      exp_w  [longint unsigned];
  bit [7:0]   init_b [longint unsigned];
  bit [7:0]   exp_b  [longint unsigned];
  bit         byte_id [int unsigned];

  bit loaded = 0;
  int unsigned n_runs = 0;
  int unsigned runs_started = 0;
  int unsigned errors = 0;

  function automatic longint unsigned key(input shortint unsigned id, input longint unsigned addr);
    return {id, addr[47:0]};
  endfunction

  function automatic longint unsigned ikey(input int unsigned run, input int unsigned id,
                                           input longint unsigned addr);
    return {run[15:0], id[15:0], addr[31:0]};
  endfunction

  function automatic word_t mask_of(input shortint unsigned bitsize);
    word_t m = '0;
    for (int i = 0; i < 4096; i++) if (i < bitsize) m[i] = 1'b1;
    return m;
  endfunction

  function automatic void load_file(input string name, input bit is_expected);
    int fd, n;
    int run, id, nbytes;
    longint unsigned addr;
    byte unsigned kind;
    word_t data;
    fd = $fopen(name, "r");
    if (fd == 0) begin
      $display("Sim: ERROR cannot open %s", name);
      $finish;
    end
    while (!$feof(fd)) begin
      n = $fscanf(fd, " %c", kind);
      if (n != 1) break;
      if (kind == "w") begin
        n = $fscanf(fd, "%d %d %h %h", run, id, addr, data);
        if (n == 4) begin
          if (is_expected) exp_w[ikey(run, id, addr)] = data;
          else             init_w[ikey(run, id, addr)] = data;
          if (run + 1 > n_runs) n_runs = run + 1;
        end
      end else if (kind == "m") begin
        n = $fscanf(fd, "%d %d %h %d %h", run, id, addr, nbytes, data);
        if (n == 5) begin
          for (int b = 0; b < nbytes; b++) begin
            if (is_expected) exp_b[ikey(run, id, addr + b)] = data[8*b +: 8];
            else             init_b[ikey(run, id, addr + b)] = data[8*b +: 8];
          end
          byte_id[id] = 1;
          if (run + 1 > n_runs) n_runs = run + 1;
        end
      end else begin
        $display("Sim: ERROR bad record '%c' in %s", kind, name);
        $finish;
      end
    end
    $fclose(fd);
  endfunction

  function automatic void load_all();
    if (!loaded) begin
      load_file("tb_init.mem", 0);
      load_file("tb_expected.mem", 1);
      loaded = 1;
      $display("Sim: %0d run(s), %0d+%0d input and %0d+%0d expected words+bytes", n_runs,
               init_w.num(), init_b.num(), exp_w.num(), exp_b.num());
    end
  endfunction

  function automatic void check_run(input int unsigned run);
    int unsigned bad = 0;
    foreach (exp_w[k]) begin
      if (k[63:48] == run[15:0]) begin
        word_t got = mem.exists(key(k[47:32], k[31:0])) ? mem[key(k[47:32], k[31:0])] : '0;
        if (got !== exp_w[k]) begin
          if (errors + bad < 16)
            $display("Sim: MISMATCH run=%0d id=%0d addr=%0d expected=%0h got=%0h",
                     run, k[47:32], k[31:0], exp_w[k], got);
          bad++;
        end
      end
    end
    foreach (exp_b[k]) begin
      if (k[63:48] == run[15:0]) begin
        bit [7:0] got = bmem.exists(key(k[47:32], k[31:0])) ? bmem[key(k[47:32], k[31:0])] : 8'h00;
        if (got !== exp_b[k]) begin
          if (errors + bad < 16)
            $display("Sim: MISMATCH run=%0d memory id=%0d byte addr=%0h expected=%0h got=%0h",
                     run, k[47:32], k[31:0], exp_b[k], got);
          bad++;
        end
      end
    end
    errors += bad;
  endfunction

  // Called by the testbench FSM in the READY state: before the first run, and after each run.
  function automatic int unsigned m_next(input int unsigned state);
    load_all();
    if (runs_started > 0) check_run(runs_started - 1);
    if (runs_started < n_runs) begin
      mem.delete();
      bmem.delete();
      foreach (init_w[k])
        if (k[63:48] == runs_started[15:0])
          mem[key(k[47:32], k[31:0])] = init_w[k];
      foreach (init_b[k])
        if (k[63:48] == runs_started[15:0])
          bmem[key(k[47:32], k[31:0])] = init_b[k];
      runs_started++;
      return STATE_SETUP;
    end
    return STATE_END;
  endfunction

  // Called by the FSM at the end of the simulation; the return code is in bits [15:8].
  function automatic int m_fini();
    $display("Sim: %0d run(s) checked, %0d mismatching word(s)", n_runs, errors);
    return (errors != 0 ? 1 : 0) << 8;
  endfunction

  function automatic int m_read(input shortint unsigned id, output logic [4095:0] data,
                                input shortint unsigned bitsize, input longint unsigned addr,
                                input byte signed cmd);
    data = '0;
    if (byte_id.exists(id)) begin
      for (int b = 0; b < (bitsize + 7) / 8; b++)
        data[8*b +: 8] = bmem.exists(key(id, addr + b)) ? bmem[key(id, addr + b)] : 8'h00;
      data = data & mask_of(bitsize);
    end else begin
      longint unsigned k = key(id, addr);
      data = mem.exists(k) ? mem[k] : '0;
    end
    return 0;
  endfunction

  function automatic int m_write(input shortint unsigned id, input logic [4095:0] data,
                                 input shortint unsigned bitsize, input longint unsigned addr,
                                 input byte signed cmd);
    if (byte_id.exists(id)) begin
      word_t d = data & mask_of(bitsize);
      for (int b = 0; b < (bitsize + 7) / 8; b++)
        bmem[key(id, addr + b)] = d[8*b +: 8];
    end else begin
      mem[key(id, addr)] = data & mask_of(bitsize);
    end
    return 0;
  endfunction

  function automatic int m_state(input shortint unsigned id, input int data);
    return 0;
  endfunction
endpackage
