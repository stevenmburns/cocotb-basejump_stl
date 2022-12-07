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


    def gen_examples():
        for _ in range(1000):
            g_i = rnd.uniform(0,1) < 0.85
            g_o = rnd.uniform(0,1) < 0.85
            yield g_i, g_o

    examples = [(True, True),
                (False, True),
                (True, True)]

    examples = gen_examples()

    q = deque()
    inp_index = 0
    for g_i, g_o in examples:
        dut._log.info(f"q = {q} g_i = {g_i} g_o = {g_o}")


        async def sample_out():
            dut.io_out_ready.value = 1 if g_o else 0
            await RisingEdge(dut.clock)        
            if dut.io_out_valid.value and dut.io_out_ready.value:
                dut._log.info(f"dequeueing {q[0]}...")
                assert q.popleft() == dut.io_out_bits.value

            await FallingEdge(dut.clock)  # Synchronize with the clock

        async def sample_inp():
            nonlocal inp_index
            dut.io_inp_valid.value = 1 if g_i else 0
            dut.io_inp_bits.value = inp_index
            await RisingEdge(dut.clock)        
            if dut.io_inp_valid.value and dut.io_inp_ready.value:
                dut._log.info(f"enqueueing {inp_index}...")
                q.append(inp_index)
                inp_index += 1

            await FallingEdge(dut.clock)  # Synchronize with the clock

        t0 = cocotb.start_soon(sample_inp())
        t1 = cocotb.start_soon(sample_out())

        await Combine(Join(t0), Join(t1))


    dut._log.info(f"q = {q}")


