module DecoupledStage(
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
  assign io_inp_ready = io_out_ready | ~io_out_valid; // @[DecoupledStage.scala 23:32]
  assign io_out_valid = out_valid; // @[DecoupledStage.scala 20:16]
  assign io_out_bits = out_bits; // @[DecoupledStage.scala 21:16]
  always @(posedge clock) begin
    if (reset) begin // @[DecoupledStage.scala 17:26]
      out_valid <= 1'h0; // @[DecoupledStage.scala 17:26]
    end else begin
      out_valid <= io_inp_valid | ~io_inp_ready; // @[DecoupledStage.scala 25:13]
    end
    if (io_inp_ready) begin // @[DecoupledStage.scala 26:24]
      out_bits <= io_inp_bits; // @[DecoupledStage.scala 27:15]
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
module Chain(
  input         clock,
  input         reset,
  output        io_inp_ready,
  input         io_inp_valid,
  input  [15:0] io_inp_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [15:0] io_out_bits
);
  wire  io_out_u_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_1_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_1_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_1_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_2_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_2_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_2_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_3_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_3_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_3_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_4_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_4_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_4_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_5_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_5_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_5_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_6_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_6_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_6_io_out_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_clock; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_reset; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_io_inp_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_io_inp_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_7_io_inp_bits; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_io_out_ready; // @[DecoupledStage.scala 91:21]
  wire  io_out_u_7_io_out_valid; // @[DecoupledStage.scala 91:21]
  wire [15:0] io_out_u_7_io_out_bits; // @[DecoupledStage.scala 91:21]
  DecoupledStage io_out_u ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_clock),
    .reset(io_out_u_reset),
    .io_inp_ready(io_out_u_io_inp_ready),
    .io_inp_valid(io_out_u_io_inp_valid),
    .io_inp_bits(io_out_u_io_inp_bits),
    .io_out_ready(io_out_u_io_out_ready),
    .io_out_valid(io_out_u_io_out_valid),
    .io_out_bits(io_out_u_io_out_bits)
  );
  DecoupledStage io_out_u_1 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_1_clock),
    .reset(io_out_u_1_reset),
    .io_inp_ready(io_out_u_1_io_inp_ready),
    .io_inp_valid(io_out_u_1_io_inp_valid),
    .io_inp_bits(io_out_u_1_io_inp_bits),
    .io_out_ready(io_out_u_1_io_out_ready),
    .io_out_valid(io_out_u_1_io_out_valid),
    .io_out_bits(io_out_u_1_io_out_bits)
  );
  DecoupledStage io_out_u_2 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_2_clock),
    .reset(io_out_u_2_reset),
    .io_inp_ready(io_out_u_2_io_inp_ready),
    .io_inp_valid(io_out_u_2_io_inp_valid),
    .io_inp_bits(io_out_u_2_io_inp_bits),
    .io_out_ready(io_out_u_2_io_out_ready),
    .io_out_valid(io_out_u_2_io_out_valid),
    .io_out_bits(io_out_u_2_io_out_bits)
  );
  DecoupledStage io_out_u_3 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_3_clock),
    .reset(io_out_u_3_reset),
    .io_inp_ready(io_out_u_3_io_inp_ready),
    .io_inp_valid(io_out_u_3_io_inp_valid),
    .io_inp_bits(io_out_u_3_io_inp_bits),
    .io_out_ready(io_out_u_3_io_out_ready),
    .io_out_valid(io_out_u_3_io_out_valid),
    .io_out_bits(io_out_u_3_io_out_bits)
  );
  DecoupledStage io_out_u_4 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_4_clock),
    .reset(io_out_u_4_reset),
    .io_inp_ready(io_out_u_4_io_inp_ready),
    .io_inp_valid(io_out_u_4_io_inp_valid),
    .io_inp_bits(io_out_u_4_io_inp_bits),
    .io_out_ready(io_out_u_4_io_out_ready),
    .io_out_valid(io_out_u_4_io_out_valid),
    .io_out_bits(io_out_u_4_io_out_bits)
  );
  DecoupledStage io_out_u_5 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_5_clock),
    .reset(io_out_u_5_reset),
    .io_inp_ready(io_out_u_5_io_inp_ready),
    .io_inp_valid(io_out_u_5_io_inp_valid),
    .io_inp_bits(io_out_u_5_io_inp_bits),
    .io_out_ready(io_out_u_5_io_out_ready),
    .io_out_valid(io_out_u_5_io_out_valid),
    .io_out_bits(io_out_u_5_io_out_bits)
  );
  DecoupledStage io_out_u_6 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_6_clock),
    .reset(io_out_u_6_reset),
    .io_inp_ready(io_out_u_6_io_inp_ready),
    .io_inp_valid(io_out_u_6_io_inp_valid),
    .io_inp_bits(io_out_u_6_io_inp_bits),
    .io_out_ready(io_out_u_6_io_out_ready),
    .io_out_valid(io_out_u_6_io_out_valid),
    .io_out_bits(io_out_u_6_io_out_bits)
  );
  DecoupledStage io_out_u_7 ( // @[DecoupledStage.scala 91:21]
    .clock(io_out_u_7_clock),
    .reset(io_out_u_7_reset),
    .io_inp_ready(io_out_u_7_io_inp_ready),
    .io_inp_valid(io_out_u_7_io_inp_valid),
    .io_inp_bits(io_out_u_7_io_inp_bits),
    .io_out_ready(io_out_u_7_io_out_ready),
    .io_out_valid(io_out_u_7_io_out_valid),
    .io_out_bits(io_out_u_7_io_out_bits)
  );
  assign io_inp_ready = io_out_u_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_valid = io_out_u_7_io_out_valid; // @[DecoupledStage.scala 97:10]
  assign io_out_bits = io_out_u_7_io_out_bits; // @[DecoupledStage.scala 97:10]
  assign io_out_u_clock = clock;
  assign io_out_u_reset = reset;
  assign io_out_u_io_inp_valid = io_inp_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_io_inp_bits = io_inp_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_io_out_ready = io_out_u_1_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_1_clock = clock;
  assign io_out_u_1_reset = reset;
  assign io_out_u_1_io_inp_valid = io_out_u_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_1_io_inp_bits = io_out_u_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_1_io_out_ready = io_out_u_2_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_2_clock = clock;
  assign io_out_u_2_reset = reset;
  assign io_out_u_2_io_inp_valid = io_out_u_1_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_2_io_inp_bits = io_out_u_1_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_2_io_out_ready = io_out_u_3_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_3_clock = clock;
  assign io_out_u_3_reset = reset;
  assign io_out_u_3_io_inp_valid = io_out_u_2_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_3_io_inp_bits = io_out_u_2_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_3_io_out_ready = io_out_u_4_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_4_clock = clock;
  assign io_out_u_4_reset = reset;
  assign io_out_u_4_io_inp_valid = io_out_u_3_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_4_io_inp_bits = io_out_u_3_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_4_io_out_ready = io_out_u_5_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_5_clock = clock;
  assign io_out_u_5_reset = reset;
  assign io_out_u_5_io_inp_valid = io_out_u_4_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_5_io_inp_bits = io_out_u_4_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_5_io_out_ready = io_out_u_6_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_6_clock = clock;
  assign io_out_u_6_reset = reset;
  assign io_out_u_6_io_inp_valid = io_out_u_5_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_6_io_inp_bits = io_out_u_5_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_6_io_out_ready = io_out_u_7_io_inp_ready; // @[DecoupledStage.scala 92:16]
  assign io_out_u_7_clock = clock;
  assign io_out_u_7_reset = reset;
  assign io_out_u_7_io_inp_valid = io_out_u_6_io_out_valid; // @[DecoupledStage.scala 92:16]
  assign io_out_u_7_io_inp_bits = io_out_u_6_io_out_bits; // @[DecoupledStage.scala 92:16]
  assign io_out_u_7_io_out_ready = io_out_ready; // @[DecoupledStage.scala 97:10]
endmodule
