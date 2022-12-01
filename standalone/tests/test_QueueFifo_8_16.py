from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_fifo():
    run(verilog_sources=[tests_dir / "QueueFifo_8_16.v"],
        toplevel="QueueFifo_8_16",
        module="fifo_cocotb",
        compile_args=["-timescale=1ps/1ps"],
        waves=True)



    
