import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.regression import TestFactory

@cocotb.coroutine
def run_test(dut):

    c = Clock(dut.clk, 1, 'ns')
    cocotb.fork(c.start())

    @cocotb.coroutine
    def stage( reset, data, enq, deq, full, empty, data_out):
        assert not enq or not deq


        dut.reset = reset
        dut.data = data
        dut.v = enq or deq
        dut.enq_not_deq = enq

        yield RisingEdge(dut.clk)
#        yield FallingEdge(dut.clk)
        yield Timer(0)

        assert dut.full == full, (int(dut.full), full)
        assert dut.empty == empty, (int(dut.empty), empty)
        if deq:
            assert dut.data_out == data_out, (int(dut.data_out), data_out)

    u = 0xDEAD

    yield stage( 1, u, False, False, 0, 1, u)
    yield stage( 0, u, False, False, 0, 1, u)
    yield stage( 0, u, False, False, 0, 1, u)
    yield stage( 0, 10, True, False, 0, 0, u)
    yield stage( 0, 11, True, False, 0, 0, u)
    yield stage( 0, 12, True, False, 0, 0, u)
    yield stage( 0, u, False, False, 0, 0, u)
    yield stage( 0, u, False, False, 0, 0, u)
    yield stage( 0, u, False, True, 0, 0, 10)
    yield stage( 0, u, False, True, 0, 0, 11)
    yield stage( 0, u, False, True, 0, 1, 12)
    yield stage( 0, 99, True, False, 0, 0, u)
    yield stage( 0, u, False, True, 0, 1, 99)
    
    for i in range(128):
        yield stage( 0, 128+i, True, False, i == 127, 0, 0)

    for i in range(128):
        yield stage( 0, 0, False, True, 0, i == 127, 128+i)

# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
