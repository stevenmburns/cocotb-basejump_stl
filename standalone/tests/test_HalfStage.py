from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_HalfStage():
    run(verilog_sources=[tests_dir / "HalfStage.v"],
        toplevel="HalfStage",
        module="fifo_cocotb",
        waves=True)



    
