`timescale 1ns/100ps

`include "pcie.v" // Agrega archivo de codigo
`include "probador_pcie.v" // Agrega archivo de probador

module pruebas_pcie();

	input wire RESET;
  	wire VALID;
	wire CLK;
	wire [7:0] DATA;

  	probador_pcie probador (RESET, CLK, DATA, Valid); 
  	pcie PCIETest (RESET, CLK, Valid, DATA); 

  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;

    	end

endmodule
