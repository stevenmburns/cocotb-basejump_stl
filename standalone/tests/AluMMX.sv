
module AluMMX(
  input         clock,
  input         reset,
  input  [15:0] a_0,
  input  [15:0] a_1,
  input  [15:0] a_2,
  input  [15:0] a_3,
  input  [15:0] b_0,
  input  [15:0] b_1,
  input  [15:0] b_2,
  input  [15:0] b_3,
  output [15:0] z_0,
  output [15:0] z_1,
  output [15:0] z_2,
  output [15:0] z_3,
  input  [1:0]  opcode,
  input  [2:0]  mode
);
  wire  ci = opcode == 2'h1; // @[alu.scala 63:16]
  wire [15:0] _bn_0_T = ~b_0; // @[alu.scala 65:35]
  wire [15:0] _bn_1_T = ~b_1; // @[alu.scala 65:35]
  wire [15:0] _bn_2_T = ~b_2; // @[alu.scala 65:35]
  wire [15:0] _bn_3_T = ~b_3; // @[alu.scala 65:35]
  wire [15:0] bn_0 = ci ? _bn_0_T : b_0; // @[alu.scala 59:20 63:25 65:32]
  wire [15:0] bn_1 = ci ? _bn_1_T : b_1; // @[alu.scala 59:20 63:25 65:32]
  wire [15:0] bn_2 = ci ? _bn_2_T : b_2; // @[alu.scala 59:20 63:25 65:32]
  wire [15:0] bn_3 = ci ? _bn_3_T : b_3; // @[alu.scala 59:20 63:25 65:32]
  wire  _T_2 = mode == 3'h4; // @[alu.scala 70:30]
  wire  s1_b = mode == 3'h2 | mode == 3'h4 | ci; // @[alu.scala 70:{39,44}]
  wire  s1_a = mode == 3'h2 | mode == 3'h4 ? 1'h0 : ci; // @[alu.scala 70:{39,44}]
  wire  s2_b = _T_2 | ci; // @[alu.scala 71:{23,28}]
  wire  s2_a = _T_2 ? 1'h0 : ci; // @[alu.scala 71:{23,28}]
  wire [66:0] a1 = {a_3,s1_a,a_2,s2_a,a_1,s1_a,a_0}; // @[alu.scala 73:60]
  wire [66:0] b1 = {bn_3,s1_b,bn_2,s2_b,bn_1,s1_b,bn_0}; // @[alu.scala 74:60]
  wire [15:0] _z_0_T = a_0 & b_0; // @[alu.scala 17:12]
  wire [15:0] _z_1_T = a_1 & b_1; // @[alu.scala 17:12]
  wire [15:0] _z_2_T = a_2 & b_2; // @[alu.scala 17:12]
  wire [15:0] _z_3_T = a_3 & b_3; // @[alu.scala 17:12]
  wire [15:0] _z_0_T_1 = a_0 | b_0; // @[alu.scala 18:12]
  wire [15:0] _z_1_T_1 = a_1 | b_1; // @[alu.scala 18:12]
  wire [15:0] _z_2_T_1 = a_2 | b_2; // @[alu.scala 18:12]
  wire [15:0] _z_3_T_1 = a_3 | b_3; // @[alu.scala 18:12]
  wire [15:0] _GEN_13 = opcode == 2'h3 ? _z_0_T_1 : _z_0_T; // @[alu.scala 78:30 80:14]
  wire [15:0] _GEN_14 = opcode == 2'h3 ? _z_1_T_1 : _z_1_T; // @[alu.scala 78:30 80:14]
  wire [15:0] _GEN_15 = opcode == 2'h3 ? _z_2_T_1 : _z_2_T; // @[alu.scala 78:30 80:14]
  wire [15:0] _GEN_16 = opcode == 2'h3 ? _z_3_T_1 : _z_3_T; // @[alu.scala 78:30 80:14]
  wire [66:0] _z1_T_1 = a1 + b1; // @[alu.scala 87:17]
  wire [66:0] _GEN_21 = {{66'd0}, ci}; // @[alu.scala 87:22]
  wire [66:0] z1 = _z1_T_1 + _GEN_21; // @[alu.scala 87:22]
  assign z_0 = opcode < 2'h2 ? z1[15:0] : _GEN_13; // @[alu.scala 86:23 88:31]
  assign z_1 = opcode < 2'h2 ? z1[32:17] : _GEN_14; // @[alu.scala 86:23 88:31]
  assign z_2 = opcode < 2'h2 ? z1[49:34] : _GEN_15; // @[alu.scala 86:23 88:31]
  assign z_3 = opcode < 2'h2 ? z1[66:51] : _GEN_16; // @[alu.scala 86:23 88:31]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"mode=%x opcode=%x a=%x b=%x z=%x\n",mode,opcode,{a_3,a_2,a_1,a_0},{b_3,b_2,b_1,b_0},{z_3
            ,z_2,z_1,z_0}); // @[alu.scala 91:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
