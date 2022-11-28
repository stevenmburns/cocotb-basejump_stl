# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, Combine, Join

import random
from collections import deque


@cocotb.test()
async def test_fifo(dut):

    rnd = random.Random()

    clock = Clock(dut.clock, 1, units="ns")  # Create a 1ns period clock on port clock
    cocotb.start_soon(clock.start())  # Start the clock

    await FallingEdge(dut.clock)  # Synchronize with the clock

    dut.reset.value = 1


    dut.io_inp_valid.value = 0
    dut.io_inp_bits.value = 0
    dut.io_out_ready.value = 0


    await FallingEdge(dut.clock)  # Synchronize with the clock
    dut.reset.value = 0

    await FallingEdge(dut.clock)  # Synchronize with the clock

    q = deque()

    
    inp_index = 0


    async def logical_step(g_i, g_o):
        nonlocal inp_index

        dut.io_out_ready.value = 1 if g_o else 0
        dut.io_inp_valid.value = 1 if g_i else 0
        dut.io_inp_bits.value = inp_index


        await Timer(0.01, 'ns')


        if dut.io_out_valid.value and dut.io_out_ready.value:
            dut._log.info(f"dequeueing {q[0]}...")
            assert q.popleft() == dut.io_out_bits.value

        if dut.io_inp_valid.value and dut.io_inp_ready.value:
            dut._log.info(f"enqueueing {inp_index}...")
            q.append(inp_index)
            inp_index += 1

        await FallingEdge(dut.clock)  # Synchronize with the clock

    for _ in range(1000):
        dut._log.info(f"q = {q}")

        g_i = rnd.uniform(0,1) < 0.5
        g_o = rnd.uniform(0,1) < 0.5

        await logical_step(g_i, g_o)

    dut._log.info(f"q = {q}")
