import random

import cocotb
from cocotb.triggers import Timer

def popcount( n, x):
    return sum( 1 for i in range(n) if x & (1<<i))

@cocotb.test()
async def run_test(dut):

    width_p = len(dut.i)

    async def stage( i, o):
        dut.i.value = i
        await Timer(1.0, 'ns')
        dut._log.info(f'input={dut.i.value}  got={dut.o.value.integer} expected={o}')
        assert int(dut.o.value) == o, (int(dut.o.value), o)

    if False:
        r = random.Random( 47)
        m = 1000
        for _ in range(m):
            v = r.randrange( 1<<width_p)
            await stage( v, popcount( width_p, v))

    if True:
        for i in range(1<<width_p):
            await stage( i, popcount( width_p, i))
