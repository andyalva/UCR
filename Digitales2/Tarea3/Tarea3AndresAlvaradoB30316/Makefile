all:
	iverilog -o b_libreria libreria.v probador_comp_logico.v libreria_tb.v
	vvp b_libreria
all_act:
	iverilog -o b_libreria libreria.v probador_cont_act.v libreria_tb.v
	vvp b_libreria
gtk:
	gtkwave libreria.vcd
clean:
	rm libreria.vcd b_libreria
