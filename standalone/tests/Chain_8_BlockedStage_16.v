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
module Chain_8_BlockedStage_16(
  input         clock,
  input         reset,
  output        io_inp_ready,
  input         io_inp_valid,
  input  [15:0] io_inp_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [15:0] io_out_bits
);
  wire  u_clock; // @[DecoupledStage.scala 137:19]
  wire  u_reset; // @[DecoupledStage.scala 137:19]
  wire  u_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_1_clock; // @[DecoupledStage.scala 137:19]
  wire  u_1_reset; // @[DecoupledStage.scala 137:19]
  wire  u_1_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_1_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_1_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_1_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_1_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_1_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_2_clock; // @[DecoupledStage.scala 137:19]
  wire  u_2_reset; // @[DecoupledStage.scala 137:19]
  wire  u_2_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_2_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_2_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_2_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_2_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_2_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_3_clock; // @[DecoupledStage.scala 137:19]
  wire  u_3_reset; // @[DecoupledStage.scala 137:19]
  wire  u_3_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_3_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_3_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_3_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_3_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_3_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_4_clock; // @[DecoupledStage.scala 137:19]
  wire  u_4_reset; // @[DecoupledStage.scala 137:19]
  wire  u_4_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_4_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_4_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_4_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_4_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_4_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_5_clock; // @[DecoupledStage.scala 137:19]
  wire  u_5_reset; // @[DecoupledStage.scala 137:19]
  wire  u_5_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_5_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_5_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_5_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_5_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_5_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_6_clock; // @[DecoupledStage.scala 137:19]
  wire  u_6_reset; // @[DecoupledStage.scala 137:19]
  wire  u_6_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_6_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_6_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_6_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_6_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_6_io_out_bits; // @[DecoupledStage.scala 137:19]
  wire  u_7_clock; // @[DecoupledStage.scala 137:19]
  wire  u_7_reset; // @[DecoupledStage.scala 137:19]
  wire  u_7_io_inp_ready; // @[DecoupledStage.scala 137:19]
  wire  u_7_io_inp_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_7_io_inp_bits; // @[DecoupledStage.scala 137:19]
  wire  u_7_io_out_ready; // @[DecoupledStage.scala 137:19]
  wire  u_7_io_out_valid; // @[DecoupledStage.scala 137:19]
  wire [15:0] u_7_io_out_bits; // @[DecoupledStage.scala 137:19]
  BlockedStage u ( // @[DecoupledStage.scala 137:19]
    .clock(u_clock),
    .reset(u_reset),
    .io_inp_ready(u_io_inp_ready),
    .io_inp_valid(u_io_inp_valid),
    .io_inp_bits(u_io_inp_bits),
    .io_out_ready(u_io_out_ready),
    .io_out_valid(u_io_out_valid),
    .io_out_bits(u_io_out_bits)
  );
  BlockedStage u_1 ( // @[DecoupledStage.scala 137:19]
    .clock(u_1_clock),
    .reset(u_1_reset),
    .io_inp_ready(u_1_io_inp_ready),
    .io_inp_valid(u_1_io_inp_valid),
    .io_inp_bits(u_1_io_inp_bits),
    .io_out_ready(u_1_io_out_ready),
    .io_out_valid(u_1_io_out_valid),
    .io_out_bits(u_1_io_out_bits)
  );
  BlockedStage u_2 ( // @[DecoupledStage.scala 137:19]
    .clock(u_2_clock),
    .reset(u_2_reset),
    .io_inp_ready(u_2_io_inp_ready),
    .io_inp_valid(u_2_io_inp_valid),
    .io_inp_bits(u_2_io_inp_bits),
    .io_out_ready(u_2_io_out_ready),
    .io_out_valid(u_2_io_out_valid),
    .io_out_bits(u_2_io_out_bits)
  );
  BlockedStage u_3 ( // @[DecoupledStage.scala 137:19]
    .clock(u_3_clock),
    .reset(u_3_reset),
    .io_inp_ready(u_3_io_inp_ready),
    .io_inp_valid(u_3_io_inp_valid),
    .io_inp_bits(u_3_io_inp_bits),
    .io_out_ready(u_3_io_out_ready),
    .io_out_valid(u_3_io_out_valid),
    .io_out_bits(u_3_io_out_bits)
  );
  BlockedStage u_4 ( // @[DecoupledStage.scala 137:19]
    .clock(u_4_clock),
    .reset(u_4_reset),
    .io_inp_ready(u_4_io_inp_ready),
    .io_inp_valid(u_4_io_inp_valid),
    .io_inp_bits(u_4_io_inp_bits),
    .io_out_ready(u_4_io_out_ready),
    .io_out_valid(u_4_io_out_valid),
    .io_out_bits(u_4_io_out_bits)
  );
  BlockedStage u_5 ( // @[DecoupledStage.scala 137:19]
    .clock(u_5_clock),
    .reset(u_5_reset),
    .io_inp_ready(u_5_io_inp_ready),
    .io_inp_valid(u_5_io_inp_valid),
    .io_inp_bits(u_5_io_inp_bits),
    .io_out_ready(u_5_io_out_ready),
    .io_out_valid(u_5_io_out_valid),
    .io_out_bits(u_5_io_out_bits)
  );
  BlockedStage u_6 ( // @[DecoupledStage.scala 137:19]
    .clock(u_6_clock),
    .reset(u_6_reset),
    .io_inp_ready(u_6_io_inp_ready),
    .io_inp_valid(u_6_io_inp_valid),
    .io_inp_bits(u_6_io_inp_bits),
    .io_out_ready(u_6_io_out_ready),
    .io_out_valid(u_6_io_out_valid),
    .io_out_bits(u_6_io_out_bits)
  );
  BlockedStage u_7 ( // @[DecoupledStage.scala 137:19]
    .clock(u_7_clock),
    .reset(u_7_reset),
    .io_inp_ready(u_7_io_inp_ready),
    .io_inp_valid(u_7_io_inp_valid),
    .io_inp_bits(u_7_io_inp_bits),
    .io_out_ready(u_7_io_out_ready),
    .io_out_valid(u_7_io_out_valid),
    .io_out_bits(u_7_io_out_bits)
  );
  assign io_inp_ready = u_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign io_out_valid = u_7_io_out_valid; // @[DecoupledStage.scala 144:10]
  assign io_out_bits = u_7_io_out_bits; // @[DecoupledStage.scala 144:10]
  assign u_clock = clock;
  assign u_reset = reset;
  assign u_io_inp_valid = io_inp_valid; // @[DecoupledStage.scala 141:14]
  assign u_io_inp_bits = io_inp_bits; // @[DecoupledStage.scala 141:14]
  assign u_io_out_ready = u_1_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_1_clock = clock;
  assign u_1_reset = reset;
  assign u_1_io_inp_valid = u_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_1_io_inp_bits = u_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_1_io_out_ready = u_2_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_2_clock = clock;
  assign u_2_reset = reset;
  assign u_2_io_inp_valid = u_1_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_2_io_inp_bits = u_1_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_2_io_out_ready = u_3_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_3_clock = clock;
  assign u_3_reset = reset;
  assign u_3_io_inp_valid = u_2_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_3_io_inp_bits = u_2_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_3_io_out_ready = u_4_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_4_clock = clock;
  assign u_4_reset = reset;
  assign u_4_io_inp_valid = u_3_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_4_io_inp_bits = u_3_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_4_io_out_ready = u_5_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_5_clock = clock;
  assign u_5_reset = reset;
  assign u_5_io_inp_valid = u_4_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_5_io_inp_bits = u_4_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_5_io_out_ready = u_6_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_6_clock = clock;
  assign u_6_reset = reset;
  assign u_6_io_inp_valid = u_5_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_6_io_inp_bits = u_5_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_6_io_out_ready = u_7_io_inp_ready; // @[DecoupledStage.scala 141:14]
  assign u_7_clock = clock;
  assign u_7_reset = reset;
  assign u_7_io_inp_valid = u_6_io_out_valid; // @[DecoupledStage.scala 141:14]
  assign u_7_io_inp_bits = u_6_io_out_bits; // @[DecoupledStage.scala 141:14]
  assign u_7_io_out_ready = io_out_ready; // @[DecoupledStage.scala 144:10]
endmodule
