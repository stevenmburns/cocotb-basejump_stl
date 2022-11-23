from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@example(2)
def test_fifo( els_p):
    width_p = 8
    run(verilog_sources=[str(testdir / "fifo_1r1w_small_toplevel.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_defines.v"),
                         str(rootdir / "basejump_stl/bsg_dataflow/bsg_fifo_1r1w_small.v")],
        toplevel="fifo_1r1w_small_toplevel",
        module="fifo_yumi_cocotb",
        includes=[str(rootdir / "basejump_stl/bsg_misc"),
                  str(rootdir / "basejump_stl/bsg_mem"),
                  str(rootdir / "basejump_stl/bsg_dataflow")],
        extra_args=["-Wno-fatal",
                    f"-pvalue+els_p={els_p}",
                    f"-pvalue+width_p={width_p}",
                    "--trace"]
    )
