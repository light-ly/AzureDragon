###################
# cocotb Variables
###################
# python test file name
MODULE = test_design
TESTCASE ?=
COVERAGE ?=
COCOTB_HDL_TIMEUNIT 	 ?= 1ns
COCOTB_HDL_TIMEPERCISION ?= 1ps

###################
# make scripts Variables
###################
SIM ?= verilator
TOP_LEVEL		?= top
TOP_LEVEL_LANG  ?= verilog
VERILOG_SOURCES ?= $(shell find $(DRAGON_HOME)/rtl -name "*.v" -or -name "*.sv")
COMPILE_ARGS    +=
SIM_ARGS		+=
EXTRA_ARGS		+=
PLUS_ARGS		+=
ifeq ("$(SIM)","verilator")
	ifeq ($(WAVES), 1)
		EXTRA_ARGS += --trace --trace-structs
	endif
	ifeq ($(COVERAGE), 1)
		EXTRA_ARGS += --coverage
	endif
endif

###################
# output path
###################
SIM_BUILD 		?= $(DRAGON_HOME)/build/$(SIM)
COCOTB_RESULTS_FILE = $(SIM_BUILD)/results.xml

include $(shell cocotb-config --makefiles)/Makefile.sim

show_wave:
	gtkwave $(DRAGON_HOME)/sim/cocotb/test/dump.vcd >/dev/null 2>&1 &

clean_all:
	make clean
	rm -rf $(DRAGON_HOME)/build

.PHONY:
	show_wave clean_all
