import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.regression import TestFactory
from collections import deque

import os

def gen_undefined(w):
    u = 0
    for i in range(0,w,32):
        m = (1<<min(w-i,32))-1
        u |= (m&0xDEADBEEF) << i
    return u

@cocotb.coroutine
def run_test(dut):

    els_p = int(os.environ["els_p"])

    print( "els_p", els_p)

    n = els_p

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.fork(c.start())

    @cocotb.coroutine
    def stage( reset_i, data_i, v_i, ready_o, v_o, data_o, yumi_i):

        dut.reset_i = reset_i
        dut.data_i = data_i
        dut.v_i = v_i
        dut.yumi_i = yumi_i

        yield RisingEdge(dut.clk_i)
        yield Timer(0)

        if v_o and yumi_i:
            assert dut.data_o == data_o, (int(dut.data_o), data_o)

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


    if False:
        for i in range(100):
            dut.v_i = 1
            dut.data_i = 47+i
            yield Timer(0.1, 'ns')
            if dut.ready_o == 0:
                # filled
                break

            if i == 0:
                assert int(dut.v_o) == 0

            yield RisingEdge(dut.clk_i)            
            yield Timer(0.1, 'ns')

            assert dut.v_o == 1
            assert int(dut.data_o) == 47, (int(dut.data_o), 47)


        dut.v_i = 0
        yield Timer(0.1, 'ns')


        for i in range(100):
            if dut.v_o == 1:
                dut.yumi_i = 1
                assert int(dut.data_o) == 47+i, (int(dut.data_o), 47+i)
            else:
                dut.yumi_i = 0
                break
            yield Timer(0.1, 'ns')
            yield RisingEdge(dut.clk_i)            
            yield Timer(0.1, 'ns')

            
        for i in range(10):
            yield RisingEdge(dut.clk_i)            
            yield Timer(0.1, 'ns')

    else:
      q = deque()

      pending_i = False
      pending_o = False

      for _ in range(1000):
        pending_i = False
        pending_o = False

        p_v = pending_i or r.uniform(0,1) < 0.8
        p_y = pending_o or r.uniform(0,1) < 0.9

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
                pending_o = False
                val_o = q.popleft()
                print(f"Pop should be {val_o} was {int(dut.data_o)}")
                assert val_o == dut.data_o, (val_o, int(dut.data_o))
            else:
                pending_o = True

        if p_v:
            if dut.ready_o ==  1:
                print(f"Push {val}")
                q.append( val)
                pending_i = False
            else:
                pending_i = True

        yield Timer(0.1, 'ns')

        print( f"B: ({int(dut.v_i)} {int(dut.data_i)} {int(dut.ready_o)}) ({int(dut.v_o)} {int(dut.data_o)} {int(dut.yumi_i)}) {q}")

        yield RisingEdge(dut.clk_i)    
        yield Timer(0.1, 'ns')

        print( f"A: ({int(dut.v_i)} {int(dut.data_i)} {int(dut.ready_o)}) ({int(dut.v_o)} {int(dut.data_o)} {int(dut.yumi_i)}) {q}")


# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
