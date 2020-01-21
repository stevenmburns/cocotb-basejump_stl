TOPLEVEL_LANG ?= verilog

SIM = verilator

VERILOG_SOURCES = ../basejump_stl/bsg_misc/bsg_defines.v ../basejump_stl/bsg_dataflow/bsg_fifo_1r1w_large.v
MODULE=fifo_yumi_cocotb
TOPLEVEL=bsg_fifo_1r1w_large
EXTRA_ARGS= -Wno-fatal -pvalue+els_p=8 -pvalue+width_p=8 --trace -I../basejump_stl/bsg_misc -I../basejump_stl/bsg_mem -I../basejump_stl/bsg_dataflow

include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim


