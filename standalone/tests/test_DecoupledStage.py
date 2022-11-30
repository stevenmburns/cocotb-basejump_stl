from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_DecoupledStage():
    run(verilog_sources=[tests_dir / "DecoupledStage.v"],
        toplevel="DecoupledStage",
        module="fifo_cocotb",
        compile_args=["-timescale=1ps/1ps"],
        waves=True)



    
