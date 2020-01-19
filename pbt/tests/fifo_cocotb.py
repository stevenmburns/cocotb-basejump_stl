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

    n = els_p

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.fork(c.start())

    @cocotb.coroutine
    def stage( reset, data, enq, deq, full, empty, data_out):
        assert not enq or not deq

        dut.reset_i = reset
        dut.data_i = data
        dut.v_i = enq or deq
        dut.enq_not_deq_i = enq

        yield RisingEdge(dut.clk_i)
        yield Timer(0)

        assert dut.full_o == full, (int(dut.full_o), full)
        assert dut.empty_o == empty, (int(dut.empty_o), empty)
        if deq:
            assert dut.data_o == data_out, (int(dut.data_o), data_out)

    w = len(dut.data_i)
    u = gen_undefined(w)

    r = random.Random( 47)

#Reset
    yield stage( 1, u, False, False, 0, 1, u)

    m = 1000


    q = deque()

    for _ in range(m):
        doit = r.uniform(0,1) < 0.8
        enq_not_deq = r.uniform(0,1) < 0.45
        if doit:
            if enq_not_deq:
                if len(q) < n:
                    v = r.randrange( 1<<w)
                    q.append(v)
                    yield stage( 0, v, True, False, len(q) == n, len(q) == 0, u)
            else:
                if len(q) > 0:
                    v = q.popleft()
                    yield stage( 0, u, False, True, len(q) == n, len(q) == 0, v)
            print( len(q), end=' ')
    print()

#Reset
    yield stage( 1, u, False, False, 0, 1, u)

    q = deque()

# Fill the queue
    for _ in range(n):
        v = r.randrange( 1<<w)
        q.append(v)
        yield stage( 0, v, True, False, len(q) == n, len(q) == 0, u)

    for _ in range(m):
        doit = r.uniform(0,1) < 0.8
        enq_not_deq = r.uniform(0,1) < 0.55
        if doit:
            if enq_not_deq and len(q) < n:
                v = r.randrange( 1<<w)
                q.append(v)
                yield stage( 0, v, True, False, len(q) == n, len(q) == 0, u)
            elif not enq_not_deq and len(q) > 0:
                v = q.popleft()
                yield stage( 0, u, False, True, len(q) == n, len(q) == 0, v)
            print( len(q), end=' ')
    print()

# Empty the queue
    for _ in range(len(q)):
        v = q.popleft()
        yield stage( 0, u, False, True, len(q) == n, len(q) == 0, v)

# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
