from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_BlockedStage():
    run(verilog_sources=[tests_dir / "BlockedStage.v"],
        toplevel="BlockedStage",
        module="fifo_cocotb",
        compile_args=["-timescale=1ps/1ps"],
        waves=True)



    
