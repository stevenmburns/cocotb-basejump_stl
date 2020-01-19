from cocotb_test.run import run
import os
from hypothesis import given, example, strategies as st, settings

from fifo_cocotb import gen_undefined
def test_gen_undefined():
    assert gen_undefined(4) == 0xF
    assert gen_undefined(8) == 0xEF
    assert gen_undefined(12) == 0xEEF
    assert gen_undefined(16) == 0xBEEF
    assert gen_undefined(32) == 0xDEADBEEF
    assert gen_undefined(33) == (0x1<<32) | 0xDEADBEEF
    assert gen_undefined(34) == (0x3<<32) | 0xDEADBEEF
    assert gen_undefined(35) == (0x7<<32) | 0xDEADBEEF
    assert gen_undefined(36) == 0xFDEADBEEF


@settings(deadline=300000,max_examples=20)
#@given(st.integers(min_value=1,max_value=4).map(lambda x: 1<<x))
@given(st.integers(min_value=2,max_value=5))
def test_fifo( els_p):
    os.environ['els_p'] = f"{els_p}"
    width_p = 8
    run(verilog_sources=["../../basejump_stl/bsg_misc/bsg_defines.v",
                         "../../basejump_stl/bsg_dataflow/bsg_fifo_1rw_large.v"],
        toplevel="bsg_fifo_1rw_large",
        module="fifo_cocotb",
        includes=["../../basejump_stl/bsg_misc",
                  "../../basejump_stl/bsg_mem"],
        extra_args=["-Wno-fatal",
                    f"-pvalue+els_p={els_p}",
                    f"-pvalue+width_p={width_p}"]
    )
