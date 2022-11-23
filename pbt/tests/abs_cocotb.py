
import cocotb
from cocotb.triggers import Timer
from cocotb.regression import TestFactory

@cocotb.test()
async def run_test(dut):
    async def stage( i, o):
        dut.a_i.value = i
        await Timer(1, units='ns')
        assert dut.o.value == o

    await stage( 0, 0)
    await stage( -1, 1)
    await stage( -2, 2)
