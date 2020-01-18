from cocotb_test.run import run
import os
from hypothesis import given, example, strategies as st, settings

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

def gen_v( width_p, output_width_p):

    with open("mypopcount_test.v", "wt") as fp:
        fp.write( f"""
module mypopcount_test ( input logic [{width_p-1}:0] i,
                         output logic [{output_width_p-1}:0] o);
        
        integer idx;

        always_comb begin
            o = 0;    
            for (idx = 0; idx < {width_p}; idx = idx + 1) begin
               o = o + i[idx];
            end
        end
   
endmodule
""")

from popcount_cocotb import popcount

def test_popcount_gold():
    assert popcount( 4,  0xF) == 4
    assert popcount( 5, 0x1F) == 5

@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    os.environ['width_p'] = f"{width_p}"
    output_width_p = log2up( width_p+1)
    gen_v( width_p, output_width_p)
    run(verilog_sources=["../mypopcount_test.v"],
        toplevel="mypopcount_test",
        module="popcount_cocotb",
        includes=["../../basejump_stl/bsg_misc"],
        extra_args=["-Wno-fatal"]
    )
