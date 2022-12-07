from util import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_fifo():
    run(verilog_sources=[tests_dir / "MooreStage.v"],
        toplevel="MooreStage",
        module="fifo_independent_cocotb",
        waves=True)



    
