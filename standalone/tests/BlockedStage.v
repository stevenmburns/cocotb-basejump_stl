module BlockedStage(
  input         clock,
  input         reset,
  output        io_inp_ready,
  input         io_inp_valid,
  input  [15:0] io_inp_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [15:0] io_out_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  out_valid; // @[DecoupledStage.scala 17:26]
  reg [15:0] out_bits; // @[DecoupledStage.scala 18:21]
  assign io_inp_ready = io_out_ready; // @[DecoupledStage.scala 23:16]
  assign io_out_valid = out_valid; // @[DecoupledStage.scala 20:16]
  assign io_out_bits = out_bits; // @[DecoupledStage.scala 21:16]
  always @(posedge clock) begin
    if (reset) begin // @[DecoupledStage.scala 17:26]
      out_valid <= 1'h0; // @[DecoupledStage.scala 17:26]
    end else if (io_inp_ready) begin // @[DecoupledStage.scala 25:23]
      out_valid <= io_inp_valid; // @[DecoupledStage.scala 26:15]
    end
    if (io_inp_ready) begin // @[DecoupledStage.scala 25:23]
      out_bits <= io_inp_bits; // @[DecoupledStage.scala 27:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  out_bits = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
