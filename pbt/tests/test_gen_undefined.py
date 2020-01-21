from bsg_util import gen_undefined

def test_gen_undefined():
    assert gen_undefined(4) == 0xF
    assert gen_undefined(8) == 0xEF
    assert gen_undefined(12) == 0xEEF
    assert gen_undefined(16) == 0xBEEF
    assert gen_undefined(32) == 0xDEADBEEF
    assert gen_undefined(33) == (0x1<<32) | 0xDEADBEEF
    assert gen_undefined(34) == (0x3<<32) | 0xDEADBEEF
    assert gen_undefined(35) == (0x7<<32) | 0xDEADBEEF
    assert gen_undefined(36) == 0xFDEADBEEF
