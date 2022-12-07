from util import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_fifo():
    run(verilog_sources=[tests_dir / "DecoupledStage.v"],
        toplevel="DecoupledStage",
        module="fifo_independent_cocotb")
