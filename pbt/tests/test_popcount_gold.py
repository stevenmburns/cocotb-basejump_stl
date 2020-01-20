
from popcount_cocotb import popcount

def test_popcount_gold():
    assert popcount( 4,  0xF) == 4
    assert popcount( 5, 0x1F) == 5

