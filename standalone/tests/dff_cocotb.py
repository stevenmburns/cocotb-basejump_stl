# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge

@cocotb.test()
async def test_dff(dut):
    """ Test that d propagates to q """

    clock = Clock(dut.clk, 1, units="ns")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    dut.reset.value = 1
    await FallingEdge(dut.clk)  # Synchronize with the clock

    for i in range(1,11):
        dut.reset.value = 0
        await FallingEdge(dut.clk)
        assert dut.q.value == i, f"output q was incorrect on the {i}th cycle"
