module MooreStage(
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
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] data_aux; // @[DecoupledStage.scala 75:21]
  reg [15:0] out_bits; // @[DecoupledStage.scala 76:21]
  reg  out_valid; // @[DecoupledStage.scala 78:26]
  reg  inp_ready; // @[DecoupledStage.scala 79:26]
  wire  _GEN_0 = io_inp_valid | inp_ready; // @[DecoupledStage.scala 86:26 87:17 79:26]
  wire  _GEN_1 = io_inp_valid | out_valid; // @[DecoupledStage.scala 78:26 86:26 87:38]
  wire  _GEN_3 = io_inp_valid & ~io_out_ready ? 1'h0 : inp_ready; // @[DecoupledStage.scala 96:51 97:17 79:26]
  wire  _GEN_4 = io_inp_valid & ~io_out_ready | out_valid; // @[DecoupledStage.scala 78:26 96:51 97:39]
  wire [15:0] _GEN_5 = io_inp_valid & ~io_out_ready ? io_inp_bits : data_aux; // @[DecoupledStage.scala 96:51 98:16 75:21]
  wire  _GEN_6 = io_inp_valid & io_out_ready | _GEN_3; // @[DecoupledStage.scala 93:50 94:17]
  wire  _GEN_7 = io_inp_valid & io_out_ready | _GEN_4; // @[DecoupledStage.scala 93:50 94:38]
  wire  _GEN_10 = ~io_inp_valid & io_out_ready | _GEN_6; // @[DecoupledStage.scala 91:50 92:17]
  wire  _GEN_14 = io_out_ready | inp_ready; // @[DecoupledStage.scala 101:26 102:17 79:26]
  wire  _GEN_15 = io_out_ready | out_valid; // @[DecoupledStage.scala 101:26 102:38 78:26]
  wire  _GEN_17 = ~inp_ready & out_valid ? _GEN_14 : inp_ready; // @[DecoupledStage.scala 100:42 79:26]
  wire  _GEN_20 = inp_ready & out_valid ? _GEN_10 : _GEN_17; // @[DecoupledStage.scala 90:43]
  wire  _GEN_24 = inp_ready & ~out_valid ? _GEN_0 : _GEN_20; // @[DecoupledStage.scala 85:43]
  assign io_inp_ready = inp_ready; // @[DecoupledStage.scala 81:16]
  assign io_out_valid = out_valid; // @[DecoupledStage.scala 82:16]
  assign io_out_bits = out_bits; // @[DecoupledStage.scala 83:16]
  always @(posedge clock) begin
    if (!(inp_ready & ~out_valid)) begin // @[DecoupledStage.scala 85:43]
      if (inp_ready & out_valid) begin // @[DecoupledStage.scala 90:43]
        if (!(~io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 91:50]
          if (!(io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 93:50]
            data_aux <= _GEN_5;
          end
        end
      end
    end
    if (inp_ready & ~out_valid) begin // @[DecoupledStage.scala 85:43]
      if (io_inp_valid) begin // @[DecoupledStage.scala 86:26]
        out_bits <= io_inp_bits; // @[DecoupledStage.scala 88:16]
      end
    end else if (inp_ready & out_valid) begin // @[DecoupledStage.scala 90:43]
      if (!(~io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 91:50]
        if (io_inp_valid & io_out_ready) begin // @[DecoupledStage.scala 93:50]
          out_bits <= io_inp_bits; // @[DecoupledStage.scala 95:20]
        end
      end
    end else if (~inp_ready & out_valid) begin // @[DecoupledStage.scala 100:42]
      if (io_out_ready) begin // @[DecoupledStage.scala 101:26]
        out_bits <= data_aux; // @[DecoupledStage.scala 103:20]
      end
    end
    if (reset) begin // @[DecoupledStage.scala 78:26]
      out_valid <= 1'h0; // @[DecoupledStage.scala 78:26]
    end else if (inp_ready & ~out_valid) begin // @[DecoupledStage.scala 85:43]
      out_valid <= _GEN_1;
    end else if (inp_ready & out_valid) begin // @[DecoupledStage.scala 90:43]
      if (~io_inp_valid & io_out_ready) begin // @[DecoupledStage.scala 91:50]
        out_valid <= 1'h0; // @[DecoupledStage.scala 92:38]
      end else begin
        out_valid <= _GEN_7;
      end
    end else if (~inp_ready & out_valid) begin // @[DecoupledStage.scala 100:42]
      out_valid <= _GEN_15;
    end
    inp_ready <= reset | _GEN_24; // @[DecoupledStage.scala 79:{26,26}]
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
  data_aux = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  out_bits = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  out_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  inp_ready = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Chain_8_MooreStage_16(
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
  MooreStage u ( // @[DecoupledStage.scala 137:19]
    .clock(u_clock),
    .reset(u_reset),
    .io_inp_ready(u_io_inp_ready),
    .io_inp_valid(u_io_inp_valid),
    .io_inp_bits(u_io_inp_bits),
    .io_out_ready(u_io_out_ready),
    .io_out_valid(u_io_out_valid),
    .io_out_bits(u_io_out_bits)
  );
  MooreStage u_1 ( // @[DecoupledStage.scala 137:19]
    .clock(u_1_clock),
    .reset(u_1_reset),
    .io_inp_ready(u_1_io_inp_ready),
    .io_inp_valid(u_1_io_inp_valid),
    .io_inp_bits(u_1_io_inp_bits),
    .io_out_ready(u_1_io_out_ready),
    .io_out_valid(u_1_io_out_valid),
    .io_out_bits(u_1_io_out_bits)
  );
  MooreStage u_2 ( // @[DecoupledStage.scala 137:19]
    .clock(u_2_clock),
    .reset(u_2_reset),
    .io_inp_ready(u_2_io_inp_ready),
    .io_inp_valid(u_2_io_inp_valid),
    .io_inp_bits(u_2_io_inp_bits),
    .io_out_ready(u_2_io_out_ready),
    .io_out_valid(u_2_io_out_valid),
    .io_out_bits(u_2_io_out_bits)
  );
  MooreStage u_3 ( // @[DecoupledStage.scala 137:19]
    .clock(u_3_clock),
    .reset(u_3_reset),
    .io_inp_ready(u_3_io_inp_ready),
    .io_inp_valid(u_3_io_inp_valid),
    .io_inp_bits(u_3_io_inp_bits),
    .io_out_ready(u_3_io_out_ready),
    .io_out_valid(u_3_io_out_valid),
    .io_out_bits(u_3_io_out_bits)
  );
  MooreStage u_4 ( // @[DecoupledStage.scala 137:19]
    .clock(u_4_clock),
    .reset(u_4_reset),
    .io_inp_ready(u_4_io_inp_ready),
    .io_inp_valid(u_4_io_inp_valid),
    .io_inp_bits(u_4_io_inp_bits),
    .io_out_ready(u_4_io_out_ready),
    .io_out_valid(u_4_io_out_valid),
    .io_out_bits(u_4_io_out_bits)
  );
  MooreStage u_5 ( // @[DecoupledStage.scala 137:19]
    .clock(u_5_clock),
    .reset(u_5_reset),
    .io_inp_ready(u_5_io_inp_ready),
    .io_inp_valid(u_5_io_inp_valid),
    .io_inp_bits(u_5_io_inp_bits),
    .io_out_ready(u_5_io_out_ready),
    .io_out_valid(u_5_io_out_valid),
    .io_out_bits(u_5_io_out_bits)
  );
  MooreStage u_6 ( // @[DecoupledStage.scala 137:19]
    .clock(u_6_clock),
    .reset(u_6_reset),
    .io_inp_ready(u_6_io_inp_ready),
    .io_inp_valid(u_6_io_inp_valid),
    .io_inp_bits(u_6_io_inp_bits),
    .io_out_ready(u_6_io_out_ready),
    .io_out_valid(u_6_io_out_valid),
    .io_out_bits(u_6_io_out_bits)
  );
  MooreStage u_7 ( // @[DecoupledStage.scala 137:19]
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
