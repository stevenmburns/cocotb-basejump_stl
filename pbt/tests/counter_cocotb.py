import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.regression import TestFactory

@cocotb.coroutine
def run_test(dut):

    c = Clock(dut.clk, 1, 'ns')
    cocotb.fork(c.start())

    print( dut.o, type(dut.o), len(dut.o))

    w = len(dut.o)
    h = len(dut.up)

    @cocotb.coroutine
    def stage( reset, up, dn, v):
        dut.reset = reset
        dut.up = up
        dut.dn = dn
        yield Timer(0)
        print( f"inps (b): {dut.reset} ({reset}) {dut.up} ({up}) {dut.dn} ({dn})")
        yield RisingEdge(dut.clk)
        print( f"inps (a): {dut.reset} ({reset}) {dut.up} ({up}) {dut.dn} ({dn})")
        yield Timer(0)
        print( f"outs: {dut.o} ({v})")

        bv = cocotb.binary.BinaryValue( binaryRepresentation=cocotb.binary.BinaryRepresentation.SIGNED_MAGNITUDE)
        bv.assign( dut.o)
#        print(bv.signed_integer)

        if v < 0:
            assert dut.o == v + (1<<w)
        else:
            assert dut.o == v

    yield stage( 1, 0, 0, 0)
    yield stage( 0, 0, 0, 0)
    for i in range(1,1<<w):
        yield stage( 0, 1, 0, i)
    for i in range(1, 1<<w):
        yield stage( 0, 0, 1, (1<<w)-1-i)
        


# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
