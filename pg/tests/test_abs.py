from cocotb_test.run import run
import pytest
import os

#@pytest.mark.parametrize("seed", range(10))
def test_abs_verilog():
    run(verilog_sources=["../../basejump_stl/bsg_misc/bsg_defines.v","../../basejump_stl/bsg_misc/bsg_abs.v","abs_test.v"], toplevel="abs_test", module="abs_cocotb",extra_args=["-Wno-fatal"])
