// DPI-free replacement for the libmdpi host interface used by the Bambu
// testbench components. The host (a C program driving the simulation over
// IPC) is replaced by an in-simulation memory model initialised from
// tb_init.mem and checked against tb_expected.mem when the run ends.
//
// File format, one word per line:  <interface id, dec> <address, hex> <data, hex>
package tb_shim_pkg;
  localparam int unsigned STATE_SETUP = 7'b0000010;
  localparam int unsigned STATE_END   = 7'b0001000;

  // Number of times the design is started. One for now; see notes.
  localparam int unsigned N_RUNS = 1;

  bit [4095:0] mem      [longint unsigned];
  bit [4095:0] expected [longint unsigned];
  bit [4095:0] exp_mask [longint unsigned];
  bit loaded = 0;
  int unsigned runs_started = 0;

  function automatic longint unsigned key(input shortint unsigned id, input longint unsigned addr);
    return {id, addr[47:0]};
  endfunction

  function automatic bit [4095:0] mask_of(input shortint unsigned bitsize);
    bit [4095:0] m = '0;
    for (int i = 0; i < 4096; i++) if (i < bitsize) m[i] = 1'b1;
    return m;
  endfunction

  function automatic void load_file(input string name, input bit is_expected);
    int fd, n;
    int id;
    longint unsigned addr;
    bit [4095:0] data;
    fd = $fopen(name, "r");
    if (fd == 0) begin
      $display("Sim: ERROR cannot open %s", name);
      $finish;
    end
    while (!$feof(fd)) begin
      n = $fscanf(fd, "%d %h %h\n", id, addr, data);
      if (n == 3) begin
        if (is_expected) expected[key(id[15:0], addr)] = data;
        else             mem[key(id[15:0], addr)] = data;
      end
    end
    $fclose(fd);
  endfunction

  function automatic void load_all();
    if (!loaded) begin
      load_file("tb_init.mem", 0);
      load_file("tb_expected.mem", 1);
      loaded = 1;
    end
  endfunction

  // Called by the testbench FSM in the READY state.
  function automatic int unsigned m_next(input int unsigned state);
    load_all();
    if (runs_started < N_RUNS) begin
      runs_started++;
      return STATE_SETUP;
    end
    return STATE_END;
  endfunction

  // Called by the FSM at the end of the simulation; the return code is in [15:8].
  function automatic int m_fini();
    int errors = 0;
    foreach (expected[k]) begin
      bit [4095:0] got = mem.exists(k) ? mem[k] : '0;
      if (got !== expected[k]) begin
        if (errors < 16)
          $display("Sim: MISMATCH id=%0d addr=%0d expected=%0h got=%0h", k[63:48], k[47:0], expected[k], got);
        errors++;
      end
    end
    $display("Sim: %0d expected words checked, %0d mismatches", expected.num(), errors);
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
