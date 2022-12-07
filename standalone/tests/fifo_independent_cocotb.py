# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, Combine, Join

from collections import deque
from itertools import product
import json

@cocotb.test()
async def test_fifo(dut):

    print(dut.__dict__)

    rnd = cocotb.random

    clock = Clock(dut.clock, 1, units="ns")  # 1ns period clock on port clock
    cocotb.start_soon(clock.start())  # Start the clock


    n = 1000
    m = 5

    results = []


    for (p_i, p_o, k) in product([0.5, 0.75, 0.85],
                                 [0.5, 0.75, 0.85],
                                 range(m)):

        seq_i = [rnd.uniform(0,1) < p_i for _ in range(n)]
        seq_o = [rnd.uniform(0,1) < p_o for _ in range(n)]

        async def sample_out():
            out_index = 0
            for g_o in seq_o:
                dut.io_out_ready.value = 1 if g_o else 0
                await RisingEdge(dut.clock)        
                if dut.io_out_valid.value and dut.io_out_ready.value:
                    dut._log.debug(f"dequeueing {out_index}...")
                    assert out_index == dut.io_out_bits.value
                    out_index += 1

                await FallingEdge(dut.clock)
            results[-1]['out_index'] = out_index

        async def sample_inp():
            inp_index = 0
            for g_i in seq_i:
                dut.io_inp_valid.value = 1 if g_i else 0
                dut.io_inp_bits.value = inp_index
                await RisingEdge(dut.clock)        
                if dut.io_inp_valid.value and dut.io_inp_ready.value:
                    dut._log.debug(f"enqueueing {inp_index}...")
                    inp_index += 1

                await FallingEdge(dut.clock)
            results[-1]['inp_index'] = inp_index

        results.append({'n': n, 'p_i': p_i, 'p_o': p_o, 'k': k})

        await FallingEdge(dut.clock)
        dut.reset.value = 1
        dut.io_inp_valid.value = 0
        dut.io_inp_bits.value = 0
        dut.io_out_ready.value = 0

        await FallingEdge(dut.clock)
        dut.reset.value = 0

        t0 = cocotb.start_soon(sample_inp())
        t1 = cocotb.start_soon(sample_out())

        await Combine(Join(t0), Join(t1))

    with open("__json", "wt") as fp:
        json.dump(results, fp=fp, indent=2)
