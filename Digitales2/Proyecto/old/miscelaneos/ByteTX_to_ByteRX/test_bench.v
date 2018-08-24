`timescale 1ns/100ps

`include "pcie.v" // Agrega archivo de codigo
`include "probador_pcie.v" // Agrega archivo de probador

module pruebas_pcie();

	input wire RESET;
  	wire Valid;
	wire CLK;
	wire [7:0] DATA;
	wire reset;

  	probador_pcie probador (RESET, reset, CLK, DATA, Valid); 
  	pcie PCIETest (RESET, reset, CLK, DATA, Valid); 

  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;

    	end

endmodule
