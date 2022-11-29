from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=2,max_value=10))
@example(8)
def test_abs_verilog(width_p):
    print(f'Running with width_p={width_p}...')
    run(verilog_sources=[str(testdir / "abs_toplevel.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_abs.v")],
        includes=[str(rootdir / "basejump_stl/bsg_misc")],
        toplevel="abs_toplevel",
        module="abs_cocotb",
        #extra_args=["-Wno-fatal", f"-pvalue+width_p={width_p}"]
        extra_args=[f"-pvalue+width_p={width_p}"]
    )
