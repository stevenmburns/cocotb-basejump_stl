import pytest
from cocotb_test.run import run
from hypothesis import given, example, strategies as st, settings

import pathlib

testdir = pathlib.Path(__file__).parent
rootdir = pathlib.Path(__file__).parent.parent.parent

@settings(deadline=300000,max_examples=20)
@given(st.integers(min_value=2,max_value=8))
@example(2)
def test_counter(val):
    max_val_p = val
    max_step_p = 1
    init_val_p = 0
    run(verilog_sources=[str(testdir / "counter_up_down_toplevel.v"),
                         str(rootdir / "basejump_stl/bsg_misc/bsg_counter_up_down.v")],
        includes=[str(rootdir / "basejump_stl/bsg_misc")],
        toplevel="counter_up_down_toplevel",
        module="counter_cocotb",
        extra_args=["-Wno-fatal",
                    f"-pvalue+max_val_p={max_val_p}",
                    f"-pvalue+max_step_p={max_step_p}",
                    f"-pvalue+init_val_p={init_val_p}"]
    )
