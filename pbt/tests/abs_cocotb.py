
import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.coroutine
def run_test(dut):

    @cocotb.coroutine
    def stage( i, o):
        dut.a_i = i
        yield Timer(1, units='ns')
        assert dut.o == o

    yield stage( 0, 0)
    yield stage( -1, 1)
    yield stage( -2, 2)


# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
