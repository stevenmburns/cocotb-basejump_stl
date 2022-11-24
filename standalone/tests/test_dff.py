from cocotb_test.simulator import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_dff_verilog():
    run(verilog_sources=[tests_dir / "dff.sv"],
        toplevel="dff_test",
        module="dff_cocotb",
        waves=True)
