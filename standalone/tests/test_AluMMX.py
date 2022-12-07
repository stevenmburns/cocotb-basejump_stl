from util import run
from pathlib import Path

tests_dir = Path(__file__).parent

def test_AluMMX():
    run(verilog_sources=[tests_dir / "AluMMX.sv"],
        toplevel="AluMMX",
        module="AluMMX_cocotb")



    
