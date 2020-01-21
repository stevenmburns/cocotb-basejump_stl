import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.regression import TestFactory
from collections import deque

from bsg_util import gen_undefined

@cocotb.coroutine
def run_test(dut):

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.fork(c.start())

    w = len(dut.data_i)
    u = gen_undefined(w)
    r = random.Random( 47)

#Reset
    dut.reset_i = 1
    dut.v_i = 0
    dut.yumi_i = 0
    yield RisingEdge(dut.clk_i)
    yield Timer(0.1, 'ns')

    yield RisingEdge(dut.clk_i)
    yield Timer(0.1, 'ns')

    dut.reset_i = 0
    yield RisingEdge(dut.clk_i)
    yield Timer(0.1, 'ns')

    q = deque()

    for _ in range(1000):
        p_v = r.uniform(0,1) < 0.8
        p_y = r.uniform(0,1) < 0.9

        if p_v:
            dut.v_i = 1
            val = r.randrange( 1<<w)
            dut.data_i = val
        else:
            dut.v_i = 0
            dut.data_i = u

        yield Timer(0.1, 'ns')

        dut.yumi_i = 0
        if p_y:
            if dut.v_o == 1:
                dut.yumi_i = 1
                val_o = q.popleft()
                print(f"Pop should be {val_o} was {int(dut.data_o)}")
                assert val_o == dut.data_o, (val_o, int(dut.data_o))

        if p_v:
            if dut.ready_o ==  1:
                print(f"Push {val}")
                q.append( val)

        yield Timer(0.1, 'ns')

        print( f"B: ({int(dut.v_i)} {int(dut.data_i)} {int(dut.ready_o)}) ({int(dut.v_o)} {int(dut.data_o)} {int(dut.yumi_i)}) {q}")

        yield RisingEdge(dut.clk_i)
        yield Timer(0.1, 'ns')

        print( f"A: ({int(dut.v_i)} {int(dut.data_i)} {int(dut.ready_o)}) ({int(dut.v_o)} {int(dut.data_o)} {int(dut.yumi_i)}) {q}")


# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
