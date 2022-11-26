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
  reg [15:0] data_aux; // @[DecoupledStage.scala 44:21]
  reg [15:0] out_bits; // @[DecoupledStage.scala 45:21]
  reg  out_valid; // @[DecoupledStage.scala 47:26]
  reg  inp_ready; // @[DecoupledStage.scala 48:26]
  wire  _GEN_0 = io_inp_valid | inp_ready; // @[DecoupledStage.scala 55:26 56:17 48:26]
  wire  _GEN_1 = io_inp_valid | out_valid; // @[DecoupledStage.scala 47:26 55:26 56:38]
  wire  _GEN_3 = io_inp_valid & ~io_out_ready ? 1'h0 : inp_ready; // @[DecoupledStage.scala 65:51 66:17 48:26]
  wire  _GEN_4 = io_inp_valid & ~io_out_ready | out_valid; // @[DecoupledStage.scala 47:26 65:51 66:39]
  wire [15:0] _GEN_5 = io_inp_valid & ~io_out_ready ? io_inp_bits : data_aux; // @[DecoupledStage.scala 65:51 67:16 44:21]
  wire  _GEN_6 = io_inp_valid & io_out_ready | _GEN_3; // @[DecoupledStage.scala 62:50 63:17]
  wire  _GEN_7 = io_inp_valid & io_out_ready | _GEN_4; // @[DecoupledStage.scala 62:50 63:38]
  wire  _GEN_10 = ~io_inp_valid & io_out_ready | _GEN_6; // @[DecoupledStage.scala 60:50 61:17]
  wire  _GEN_14 = io_out_ready | inp_ready; // @[DecoupledStage.scala 70:26 71:17 48:26]
  wire  _GEN_15 = io_out_ready | out_valid; // @[DecoupledStage.scala 47:26 70:26 71:38]
  wire  _GEN_17 = ~inp_ready & out_valid ? _GEN_14 : inp_ready; // @[DecoupledStage.scala 48:26 69:42]
  wire  _GEN_20 = inp_ready & out_valid ? _GEN_10 : _GEN_17; // @[DecoupledStage.scala 59:43]
  wire  _GEN_24 = inp_ready & ~out_valid ? _GEN_0 : _GEN_20; // @[DecoupledStage.scala 54:43]
  assign io_inp_ready = inp_ready; // @[DecoupledStage.scala 50:16]
  assign io_out_valid = out_valid; // @[DecoupledStage.scala 51:16]
  assign io_out_bits = out_bits; // @[DecoupledStage.scala 52:16]
  always @(posedge clock) begin
    if (!(inp_ready & ~out_valid)) begin // @[DecoupledStage.scala 54:43]
      if (inp_ready & out_valid) begin // @[DecoupledStage.scala 59:43]
        if (!(~io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 60:50]
          if (!(io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 62:50]
            data_aux <= _GEN_5;
          end
        end
      end
    end
    if (inp_ready & ~out_valid) begin // @[DecoupledStage.scala 54:43]
      if (io_inp_valid) begin // @[DecoupledStage.scala 55:26]
        out_bits <= io_inp_bits; // @[DecoupledStage.scala 57:16]
      end
    end else if (inp_ready & out_valid) begin // @[DecoupledStage.scala 59:43]
      if (!(~io_inp_valid & io_out_ready)) begin // @[DecoupledStage.scala 60:50]
        if (io_inp_valid & io_out_ready) begin // @[DecoupledStage.scala 62:50]
          out_bits <= io_inp_bits; // @[DecoupledStage.scala 64:20]
        end
      end
    end else if (~inp_ready & out_valid) begin // @[DecoupledStage.scala 69:42]
      if (io_out_ready) begin // @[DecoupledStage.scala 70:26]
        out_bits <= data_aux; // @[DecoupledStage.scala 72:20]
      end
    end
    if (reset) begin // @[DecoupledStage.scala 47:26]
      out_valid <= 1'h0; // @[DecoupledStage.scala 47:26]
    end else if (inp_ready & ~out_valid) begin // @[DecoupledStage.scala 54:43]
      out_valid <= _GEN_1;
    end else if (inp_ready & out_valid) begin // @[DecoupledStage.scala 59:43]
      if (~io_inp_valid & io_out_ready) begin // @[DecoupledStage.scala 60:50]
        out_valid <= 1'h0; // @[DecoupledStage.scala 61:38]
      end else begin
        out_valid <= _GEN_7;
      end
    end else if (~inp_ready & out_valid) begin // @[DecoupledStage.scala 69:42]
      out_valid <= _GEN_15;
    end
    inp_ready <= reset | _GEN_24; // @[DecoupledStage.scala 48:{26,26}]
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
