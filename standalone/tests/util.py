
import cocotb_test.simulator
import os

def run(**kwargs):

    sim = os.environ.get('SIM')

    extra_args = []
    if sim is not None and sim == "vcs":
        extra_args = ["-timescale=1ps/1ps"]

    if 'extra_args' in kwargs:
        kwargs['extra_args'] += extra_args
    else:
        kwargs['extra_args'] = extra_args

    print(kwargs)

    cocotb_test.simulator.run(**kwargs)
