all:
	iverilog -o registro libreria.v log_accion.v log_decision.v log_salida.v reg_e.v reg_c.v reg_tb.v probador.v
	vvp registro
gtk:
	gtkwave registro.gtkw
clean:
	rm *.vcd registro
