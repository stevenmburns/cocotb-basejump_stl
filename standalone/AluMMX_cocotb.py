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

    dut.a_0.value = 0
    dut.a_1.value = 1
    dut.a_2.value = 2
    dut.a_3.value = 3
    dut.b_0.value = 3
    dut.b_1.value = 2
    dut.b_2.value = 1
    dut.b_3.value = 0

    dut.mode.value = 1
    dut.opcode.value = 0

    await FallingEdge(dut.clock)
    assert dut.z_0.value == 3, f"output z_0 incorrect"
    assert dut.z_1.value == 3, f"output z_1 incorrect"
    assert dut.z_2.value == 3, f"output z_2 incorrect"
    assert dut.z_3.value == 3, f"output z_3 incorrect"

    dut.a_0.value = 0
    dut.a_1.value = 1
    dut.a_2.value = 2
    dut.a_3.value = 3
    dut.b_0.value = 3
    dut.b_1.value = 2
    dut.b_2.value = 1
    dut.b_3.value = 0

    dut.mode.value = 1
    dut.opcode.value = 1

    await FallingEdge(dut.clock)
    assert dut.z_0.value == (1<<16) - 3, f"output z_0 incorrect"
    assert dut.z_1.value == (1<<16) - 1, f"output z_1 incorrect"
    assert dut.z_2.value == 1, f"output z_2 incorrect"
    assert dut.z_3.value == 3, f"output z_3 incorrect"
    
