all:
	iverilog -o asd test_bench.v
	vvp asd
	gtkwave simulation.vcd