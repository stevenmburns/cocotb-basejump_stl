# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge, Timer

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

    async def logical_step(g_i, g_o, value):

        dut._log.info(f"g_i={g_i} g_o={g_o} value={value}")

        dut.io_inp_valid.value = 0
        if g_i:
            dut.io_inp_valid.value = 1; dut.io_inp_bits.value = value
        dut.io_out_ready.value = 0
        if g_o:
           dut.io_out_ready.value = 1

        await Timer(0.01, 'ns')

        if dut.io_out_valid.value and g_o:
            dut._log.info(f"dequeueing {q[0]}...")
            assert q.popleft() == dut.io_out_bits.value

        if g_i and dut.io_inp_ready.value:
            dut._log.info(f"enqueueing {value}...")
            q.append(value)

        await FallingEdge(dut.clock)  # Synchronize with the clock

    for i in range(1000):
        dut._log.info(f"q = {q}")


        g_i = rnd.uniform(0,1) < 0.8
        g_o = rnd.uniform(0,1) < 0.8

        await logical_step(g_i, g_o, i)

    dut._log.info(f"q = {q}")
