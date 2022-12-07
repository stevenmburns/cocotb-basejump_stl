from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_fifo():
    run(verilog_sources=[tests_dir / "BlockedStage.v"],
        toplevel="BlockedStage",
        module="fifo_independent_cocotb",
        waves=True)



    
