all:
	iverilog -o byte_stripingRX byte_stripingRx.v
	iverilog -o bpbs bpbs.v
	iverilog -o tbbs tbbs.v
	vvp tbbs
	gtkwave prueba_Byte_StripingRX.vcd
	
clean:
	rm byte_stripingRX bpbs tbbs prueba_Byte_StripingRX.vcd
