
#VARIABLES
NAME='ascensor'

SRC='test_bench.v'
CC='iverilog'
CC_OUT='ascensor.x'

RUN='vvp'
VFLAGS='-o'

SYNTH='yosys'
SFLAGS='-c'
SYNTH_OUT='synth.v'

DEPDIR=''
DEPDIR_0='vlib/standar_lib.v'
DEPDIR_1='vlib/cmos_cells.v'
DEPDIR_2='vlib/delay_cmos_cells.v'


#SELECT DEPENDENCY DIRECTORY
TECH?=0

ifeq ($(TECH),0)
	DEPDIR=$(DEPDIR_0)
else
ifeq ($(TECH),1)
	DEPDIR=$(DEPDIR_1)
else
ifeq ($(TECH),2)
	DEPDIR=$(DEPDIR_2)
endif
endif
endif


#ACCTIONS
all:
	$(SYNTH) $(SFLAGS) $(NAME).tcl
	echo '`include "'$(DEPDIR)'"' | cat - $(SYNTH_OUT) > temp && mv temp $(SYNTH_OUT)
	$(CC) $(VFLAGS) $(CC_OUT) $(SRC)
	$(RUN) $(CC_OUT)

gtk:
	gtkwave simulation.gtkw

clean:
	rm -rf *.vcd $(CC_OUT) synth.v

.PHONY: all gtk clean
