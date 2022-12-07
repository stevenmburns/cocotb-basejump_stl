from cocotb_test.run import run
import os
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

compile_args = []
if os.environ.get('SIM','') == 'vcs':
    compile_args=["-timescale=1ps/1ps"]

@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=10))
@example(7)
def test_popcount( width_p):
    print(f'========= Running test with width_p = {width_p} ===============')
    run(verilog_sources=[str(testdir / "popcount_toplevel.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_defines.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_popcount.v")],
        toplevel="popcount_toplevel",
        module="popcount_cocotb",
        includes=[str(rootdir / "basejump_stl/bsg_misc")],
        compile_args=compile_args,
        extra_args=["-Wno-fatal", f"-pvalue+width_p={width_p}", "-DALLOW_TOPLEVEL"]
    )
