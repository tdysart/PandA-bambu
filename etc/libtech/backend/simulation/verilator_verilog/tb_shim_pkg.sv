// DPI-free replacement for the libmdpi host interface used by the Bambu testbench components
// (selected by defining BAMBU_TB_VERILOG, see NC_TESTBENCH_IPs.xml).
//
// The host process that normally answers the DPI calls is replaced by an in-simulation memory
// model. The memory is loaded, one run at a time, from tb_init.mem and each run is checked
// against tb_expected.mem when it ends. Both files hold one word per line:
//
//     <run, dec> <interface id, dec> <element address, hex> <data, hex>
//
// They are written by the capture step of the verilator_verilog backend, which runs the user's
// testbench natively (see capture/include/mdpi/mdpi_wrapper.h).
package tb_shim_pkg;
  localparam int unsigned STATE_SETUP = 7'b0000010;
  localparam int unsigned STATE_END   = 7'b0001000;

  typedef bit [4095:0] word_t;

  word_t mem      [longint unsigned];  // current run, key(id, addr)
  word_t init_img [longint unsigned];  // all runs,    ikey(run, id, addr)
  word_t exp_img  [longint unsigned];

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
    int run, id;
    longint unsigned addr;
    word_t data;
    fd = $fopen(name, "r");
    if (fd == 0) begin
      $display("Sim: ERROR cannot open %s", name);
      $finish;
    end
    while (!$feof(fd)) begin
      n = $fscanf(fd, "%d %d %h %h\n", run, id, addr, data);
      if (n == 4) begin
        if (is_expected) exp_img[ikey(run, id, addr)] = data;
        else             init_img[ikey(run, id, addr)] = data;
        if (run + 1 > n_runs) n_runs = run + 1;
      end
    end
    $fclose(fd);
  endfunction

  function automatic void load_all();
    if (!loaded) begin
      load_file("tb_init.mem", 0);
      load_file("tb_expected.mem", 1);
      loaded = 1;
      $display("Sim: %0d run(s), %0d input and %0d expected words", n_runs, init_img.num(), exp_img.num());
    end
  endfunction

  function automatic void check_run(input int unsigned run);
    int unsigned bad = 0;
    foreach (exp_img[k]) begin
      if (k[63:48] == run[15:0]) begin
        word_t got = mem.exists(key(k[47:32], k[31:0])) ? mem[key(k[47:32], k[31:0])] : '0;
        if (got !== exp_img[k]) begin
          if (errors + bad < 16)
            $display("Sim: MISMATCH run=%0d id=%0d addr=%0d expected=%0h got=%0h",
                     run, k[47:32], k[31:0], exp_img[k], got);
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
      foreach (init_img[k])
        if (k[63:48] == runs_started[15:0])
          mem[key(k[47:32], k[31:0])] = init_img[k];
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
    longint unsigned k = key(id, addr);
    data = mem.exists(k) ? mem[k] : '0;
    return 0;
  endfunction

  function automatic int m_write(input shortint unsigned id, input logic [4095:0] data,
                                 input shortint unsigned bitsize, input longint unsigned addr,
                                 input byte signed cmd);
    mem[key(id, addr)] = data & mask_of(bitsize);
    return 0;
  endfunction

  function automatic int m_state(input shortint unsigned id, input int data);
    return 0;
  endfunction
endpackage
