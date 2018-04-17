module alarma_desc_estructural (
	output 	sAlr,	// No se indica el tipo de sAlr,  wire implícito
	input 	sLuz,	// No se indica el tipo de sLuz,  wire implícito
	input 	sPrta,	// No se indica el tipo de sPrta, wire implícito
	input 	sIgn);	// No se indica el tipo de sIgn,  wire implícito
	// En las descripciones estructurales, los puertos de entrada y 
	// salida siempre son wires.
	// wire x; // En este escenario, la declaración de x es implícita
	// Compuerta "not" primitiva de Verilog, retardo de propagación = 1
	not #1 gate1(	x,	// Salida, primer puerto
			sIgn);	// Entradas, segundo puerto y otros

	// Compuerta "and" primitiva de Verilog, retardo de propagación = 1
	and #1 gate2(	sAlr,	// Salida, primer puerto
			sLuz,	// Entradas, segundo puerto y otros
			sPrta,
			x);
endmodule
