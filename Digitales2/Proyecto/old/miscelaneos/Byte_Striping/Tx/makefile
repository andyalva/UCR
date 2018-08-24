all:
	iverilog -o byte_stripingTX byte_stripingTx.v
	iverilog -o bpbs bpbs.v
	iverilog -o tbbs tbbs.v
	vvp tbbs
	gtkwave prueba_Byte_StripingTX.vcd
	
clean:
	rm byte_stripingTX bpbs tbbs prueba_Byte_StripingTX.vcd
