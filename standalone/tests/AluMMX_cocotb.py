# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge


@cocotb.test()
async def test_AluMMX_simple(dut):

    clock = Clock(dut.clock, 10, units="us")  # Create a 10us period clock on port clk
    cocotb.start_soon(clock.start())  # Start the clock

    await FallingEdge(dut.clock)  # Synchronize with the clock

    async def set_and_check(mode, opcode, a, b, z):
        dut.mode.value = mode
        dut.opcode.value = opcode
        dut.a_0.value, dut.a_1.value, dut.a_2.value, dut.a_3_value = a
        dut.b_0.value, dut.b_1.value, dut.b_2.value, dut.b_3_value = b
        await FallingEdge(dut.clock)
        assert (dut.z_0.value, dut.z_1.value, dut.z_2.value, dut.z_3.value) == z


    m = 1<<16
    set_and_check( 1, 0, (0,1,2,3), (3,2,1,0), (3,3,3,3))
    set_and_check( 1, 1, (0,1,2,3), (3,2,1,0), (m-3,m-1,1,3))
