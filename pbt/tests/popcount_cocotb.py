import random

import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

import os

def popcount( n, x):
    return sum( 1 for i in range(n) if x & (1<<i))

@cocotb.coroutine
def run_test(dut):

    width_p = int(os.environ["width_p"])

    @cocotb.coroutine
    def stage( i, o):

        dut.i = i

        yield Timer(1.0, 'ns')

        assert int(dut.o) == o, (int(dut.o), o)

    r = random.Random( 47)

    m = 1000

    for i in range(m):
        v = r.randrange( 1<<width_p)
        yield stage( v, popcount( width_p, v))

# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
