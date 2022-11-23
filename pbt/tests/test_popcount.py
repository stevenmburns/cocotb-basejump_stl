from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    run(verilog_sources=[str(testdir / "popcount_toplevel.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_defines.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_popcount.v")],
        toplevel="popcount_toplevel",
        module="popcount_cocotb",
        includes=[str(rootdir / "basejump_stl/bsg_misc")],
        extra_args=["-Wno-fatal", f"-pvalue+width_p={width_p}"]
    )
