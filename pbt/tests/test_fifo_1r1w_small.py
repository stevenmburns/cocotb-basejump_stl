from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@example(2)
def test_fifo( els_p):
    width_p = 8
    run(verilog_sources=["../basejump_stl/bsg_misc/bsg_defines.v",
                         "../basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small.v"],
        toplevel="bsg_fifo_1r1w_small",
        module="fifo_yumi_cocotb",
        includes=["../basejump_stl/bsg_misc",
                  "../basejump_stl/bsg_mem",
                  "../basejump_stl/bsg_dataflow"],
        extra_args=["-Wno-fatal",
                    f"-pvalue+els_p={els_p}",
                    f"-pvalue+width_p={width_p}",
                    "--trace"]
    )
