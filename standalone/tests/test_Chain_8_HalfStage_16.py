from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_fifo():
    run(verilog_sources=[tests_dir / "Chain_8_HalfStage_16.v"],
        toplevel="Chain_8_HalfStage_16",
        module="fifo_independent_cocotb",
        waves=True)



    
