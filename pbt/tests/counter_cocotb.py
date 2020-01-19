import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
from cocotb.regression import TestFactory

@cocotb.coroutine
def run_test(dut):

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.fork(c.start())

    w = len(dut.count_o)

    @cocotb.coroutine
    def stage( reset, up, dn, v):
        dut.reset_i = reset
        dut.up_i = up
        dut.down_i = dn

        yield RisingEdge(dut.clk_i)
        yield Timer(0)

        if v < 0:
            assert dut.count_o == v + (1<<w)
        else:
            assert dut.count_o == v

    yield stage( 1, 0, 0, 0)
    yield stage( 0, 0, 0, 0)
    for i in range(1,1<<w):
        yield stage( 0, 1, 0, i)
    for i in range(1, 1<<w):
        yield stage( 0, 0, 1, (1<<w)-1-i)

# Register the test.
factory = TestFactory(run_test)
factory.generate_tests()
