from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    run(verilog_sources=["tests/mypopcount.v"],
        toplevel="mypopcount",
        module="popcount_cocotb",
        extra_args=["-Wno-fatal",f"-pvalue+width_p={width_p}"]
    )
