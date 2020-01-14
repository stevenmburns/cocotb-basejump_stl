from cocotb_test.run import run
import pytest
import os
from hypothesis import given, example, strategies as st, settings

def gen_v( width_p, els_p):

    with open("fifo_test.v", "wt") as fp:
        fp.write( f"""
module fifo_test ( input logic clk,
                   input logic reset,
                   input logic [{width_p-1}:0] data,
                   input logic v,
                   input logic enq_not_deq,
        
                   output logic full,
                   output logic empty,
                   output logic [{width_p-1}:0] data_out);

        bsg_fifo_1rw_large #(.width_p({width_p}), .els_p({els_p}), .verbose_p(0)) u0 ( .clk_i(clk), .reset_i(reset), .data_i(data), .v_i(v), .enq_not_deq_i(enq_not_deq), .full_o(full), .empty_o(empty), .data_o(data_out));
   
endmodule
""")

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=7,max_value=64))
def test_fifo( width_p):
    gen_v( width_p, 128)
    run(verilog_sources=["../../basejump_stl/bsg_misc/bsg_defines.v","../../basejump_stl/bsg_dataflow/bsg_fifo_1rw_large.v","../fifo_test.v"], toplevel="fifo_test", module="fifo_cocotb", includes=["../../basejump_stl/bsg_misc","../../basejump_stl/bsg_mem"])
