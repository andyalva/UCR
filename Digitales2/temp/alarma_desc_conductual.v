module alarma_desc_conductual (
	output reg	sAlr,	// sAlr de tipo reg, almacena el valor
	input 		sLuz,	// No se indica el tipo de sLuz,  wire implícito
	input 		sPrta,	// No se indica el tipo de sPrta, wire implícito
	input 		sIgn);	// No se indica el tipo de sIgn,  wire implícito
	// En las descripciones conductuales, los puertos de entrada son wires.
	// Los puertos de salida pueden ser wires o regs, dependiendo de la
	// implementación.

	always @ (*) begin // always combinacional, bloque de procedimiento/comportamiento
	// (*) Lista de sensitividad, entra al "always" ante cualquier cambio
	// en (sLuz or sPrta or sIgn)
		if (sLuz == 1 & sPrta == 1 & sIgn == 0)
			sAlr 	= 1;	// Asignación bloqueante (=)
      		else
			sAlr	= 0;	// Asignación bloqueante (=)
    	end
endmodule
