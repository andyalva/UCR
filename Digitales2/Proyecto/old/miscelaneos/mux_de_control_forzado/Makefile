
NAME='mux_de_control_forzado'
SRC='test_bench.v'

VC='iverilog'
VCFLAGS='-o'
VC_OUT=$(NAME).o

VC_RUN='vvp'

SYNTH='yosys'
SYNTHFLAGS='-c'
SYNTH_NAME='synth'

DIR_VCLIB='../../include/common/v_tech_lib/cmos.v'
DIR_SYNTHLIB='../../include/common/yosys_lib/cmos.lib'

all:
	$(VC) $(VCFLAGS) $(VC_OUT) $(SRC)
	$(VC_RUN) $(VC_OUT)

synth:
	touch $(SYNTH_NAME).v
	touch $(SYNTH_NAME).tcl
	echo -e 'set NAME $(NAME) \nset YSYS_FILE_OUT $(SYNTH_NAME).v \nset YSYS_LIB_NAME $(DIR_SYNTHLIB)' | cat - $(SYNTH_NAME).txt > temp && mv temp $(SYNTH_NAME).tcl
	$(SYNTH) $(SYNTHFLAGS) $(SYNTH_NAME).tcl
	echo '`include "'$(DIR_VCLIB)'"' | cat - $(SYNTH_NAME).v > temp && mv temp $(SYNTH_NAME).v

gtk:
	gtkwave simulation.gtkw

clean:
	rm -rf *.vcd *.tcl $(VC_OUT) $(SYNTH_NAME).v

.PHONY: all synth gtk clean
