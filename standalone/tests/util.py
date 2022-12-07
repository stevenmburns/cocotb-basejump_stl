
import cocotb_test.simulator
import os

def run(**kwargs):

    sim = os.environ.get('SIM')

    extra_args = []
    if sim is None:
        pass
    elif sim == "vcs":
        extra_args.append("-timescale=1ps/1ps")
    elif sim == "verilator":
        extra_args.extend(["--trace", "--trace-structs"])

    if 'extra_args' not in kwargs:
        kwargs['extra_args'] = []

    kwargs['extra_args'] += extra_args

    print(kwargs)

    cocotb_test.simulator.run(**kwargs)
