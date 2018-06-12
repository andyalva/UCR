
set NAME ascensor

set VLOG_FILE_NAME $NAME
append VLOG_FILE_NAME ".v"

set YSYS_FILE_OUT synth.v
set YSYS_LIB_NAME vlib/cmos_cells.lib


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


