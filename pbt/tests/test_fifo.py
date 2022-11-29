from cocotb_test.run import run
import os
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_fifo( els_p):
    os.environ['els_p'] = f"{els_p}"
    width_p = 8
    run(verilog_sources=[str(rootdir / "basejump_stl/bsg_dataflow/bsg_fifo_1rw_large.v")],
        toplevel="bsg_fifo_1rw_large",
        module="fifo_cocotb",
        includes=[str(rootdir / "basejump_stl/bsg_misc"),
                  str(rootdir / "basejump_stl/bsg_mem")],
        extra_args=["-Wno-fatal",
                    f"-pvalue+els_p={els_p}",
                    f"-pvalue+width_p={width_p}"]
    )
