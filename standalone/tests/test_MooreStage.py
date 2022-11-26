from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_MooreStage():
    run(verilog_sources=[tests_dir / "MooreStage.v"],
        toplevel="MooreStage",
        module="fifo_cocotb",
        waves=True)



    
