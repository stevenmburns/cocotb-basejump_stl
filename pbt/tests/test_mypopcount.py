from cocotb_test.run import run
import os
from hypothesis import given, example, strategies as st, settings
import pathlib

testdir = pathlib.Path(__file__).parent

compile_args = []
if os.environ.get('SIM','') == 'vcs':
    compile_args=["-timescale=1ps/1ps"]

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=2,max_value=5))
@example(2)
def test_popcount( width_p):
    run(verilog_sources=[str(testdir / "mypopcount.v")],
        toplevel="mypopcount",
        module="popcount_cocotb",
        compile_args=compile_args,
        extra_args=["-Wno-fatal",f"-pvalue+width_p={width_p}"]
    )
