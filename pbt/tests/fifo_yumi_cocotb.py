import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, FallingEdge
from collections import deque

from bsg_util import gen_undefined

@cocotb.test()
async def run_test(dut):

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.start_soon(c.start())
    await FallingEdge(dut.clk_i)

    w = len(dut.data_i)
    u = gen_undefined(w)
    r = random.Random( 47)

#Reset
    dut.reset_i.value = 1
    dut.v_i.value = 0
    dut.yumi_i.value = 0
    await FallingEdge(dut.clk_i)

    await FallingEdge(dut.clk_i)

    dut.reset_i.value = 0
    await FallingEdge(dut.clk_i)

    q = deque()

    for _ in range(1000):
        p_v = r.uniform(0,1) < 0.2
        p_y = r.uniform(0,1) < 0.2

        if p_v:
            dut.v_i.value = 1
            val = r.randrange( 1<<w)
            dut.data_i.value = val
        else:
            dut.v_i.value = 0
            dut.data_i.value = u

        dut._log.info( f"BB: ({dut.v_i.value} {dut.data_i.value.integer} {dut.ready_o.value}) ({dut.v_o.value} {dut.data_o.value.integer} {dut.yumi_i.value}) {q}")

        # Update delta cycles?
        await Timer(0.01, 'ns')

        if p_y and dut.v_o.value == 1:
            dut.yumi_i.value = 1
            val_o = q.popleft()
            dut._log.info(f"Pop should be {val_o} was {dut.data_o.value.integer}")
            assert val_o == dut.data_o.value, (val_o, dut.data_o.value.integer)
        else:
            dut.yumi_i.value = 0

        # Update delta cycles?
        await Timer(0.01, 'ns')

        if p_v and dut.ready_o.value ==  1:
            dut._log.info(f"Push {val}")
            q.append( val)

        # Update delta cycles?
        await Timer(0.01, 'ns')

        dut._log.info( f"B: ({dut.v_i.value} {dut.data_i.value.integer} {dut.ready_o.value}) ({dut.v_o.value} {dut.data_o.value.integer} {dut.yumi_i.value}) {q}")

        await FallingEdge(dut.clk_i)

        dut._log.info( f"A: ({dut.v_i.value} {dut.data_i.value.integer} {dut.ready_o.value}) ({dut.v_o.value} {dut.data_o.value.integer} {dut.yumi_i.value}) {q}")
