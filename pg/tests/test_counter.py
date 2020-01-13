from cocotb_test.run import run
import pytest
import os


def log2up( x):
    y = 1
    while x >= (1<<y):
        y += 1
    return y

def test_log2up():
    assert log2up( 1) == 1
    assert log2up( 2) == 2
    assert log2up( 4) == 3
    assert log2up( 7) == 3
    assert log2up( 8) == 4
    assert log2up( 9) == 4


def gen_v( max_val_p, max_step_p):
    w = log2up( max_val_p)
    h = log2up( max_step_p)

    with open("counter_test.v", "wt") as fp:
        fp.write( f"""
module counter_test ( input logic clk, input logic reset, input logic [{h-1}:0] up, input logic [{h-1}:0] dn, output logic [{w-1}:0] o);

   bsg_counter_up_down #(.max_val_p({max_val_p}), .max_step_p({max_step_p}), .init_val_p(0)) u0 ( .clk_i(clk), .reset_i(reset), .up_i(up), .down_i(dn), .count_o(o));
   
   
endmodule
""")

@pytest.mark.parametrize("val", [2])
def test_counter(val):
    gen_v( val, 1)
    run(verilog_sources=["../../basejump_stl/bsg_misc/bsg_defines.v","../../basejump_stl/bsg_misc/bsg_counter_up_down.v","counter_test.v"], toplevel="counter_test", module="counter_cocotb")
