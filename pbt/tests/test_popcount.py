from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings

@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    run(verilog_sources=["../basejump_stl/bsg_misc/bsg_defines.v","../basejump_stl/bsg_misc/bsg_popcount.v"],
        toplevel="bsg_popcount",
        module="popcount_cocotb",
        includes=["../basejump_stl/bsg_misc"],
        extra_args=["-Wno-fatal", f"-pvalue+width_p={width_p}"]
    )
