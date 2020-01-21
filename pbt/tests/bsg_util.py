
def gen_undefined(w):
    u = 0
    for i in range(0,w,32):
        m = (1<<min(w-i,32))-1
        u |= (m&0xDEADBEEF) << i
    return u
