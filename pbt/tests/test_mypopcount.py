from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings

from popcount_cocotb import popcount

def test_popcount_gold():
    assert popcount( 4,  0xF) == 4
    assert popcount( 5, 0x1F) == 5

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    run(verilog_sources=["mypopcount.v"],
        toplevel="mypopcount",
        module="popcount_cocotb",
        extra_args=["-Wno-fatal",f"-pvalue+width_p={width_p}"]
    )
