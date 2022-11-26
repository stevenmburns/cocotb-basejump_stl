from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_Chain():
    run(verilog_sources=[tests_dir / "Chain.v"],
        toplevel="Chain",
        module="fifo_cocotb",
        waves=True)



    
