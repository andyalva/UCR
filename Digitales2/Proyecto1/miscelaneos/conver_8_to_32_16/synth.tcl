set NAME size_convert 
set YSYS_FILE_OUT synth.v 
set YSYS_LIB_NAME ../../include/common/yosys_lib/cmos.lib
set VLOG_FILE_NAME convert.v

# read design
yosys read_verilog $VLOG_FILE_NAME

# elaborate design hierarchy
yosys hierarchy -check -top $NAME

# the high-level stuff
yosys proc
yosys opt
yosys fsm
yosys opt
yosys memory
yosys opt

# mapping to internal cell library
yosys techmap
yosys opt

# mapping flip-flops to **.lib
yosys dfflibmap -liberty $YSYS_LIB_NAME

# mapping logic to **.lib
yosys abc -liberty $YSYS_LIB_NAME

# cleanup
yosys clean

# write synthesized design
yosys write_verilog $YSYS_FILE_OUT


