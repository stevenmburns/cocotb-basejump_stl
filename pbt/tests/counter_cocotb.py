import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def run_test(dut):

    c = Clock(dut.clk_i, 1, 'ns')
    cocotb.start_soon(c.start())

    w = len(dut.count_o.value)

    async def stage( reset, up, dn, v):
        dut.reset_i.value = reset
        dut.up_i.value = up
        dut.down_i.value = dn

        await RisingEdge(dut.clk_i)
        await Timer(0)

        if v < 0:
            assert dut.count_o.value == v + (1<<w)
        else:
            assert dut.count_o.value == v

    await stage( 1, 0, 0, 0)
    await stage( 0, 0, 0, 0)
    for i in range(1,1<<w):
        await stage( 0, 1, 0, i)
    for i in range(1, 1<<w):
        await stage( 0, 0, 1, (1<<w)-1-i)
