`timescale 1ns/100ps

`include "pcie.v" // Agrega archivo de codigo
`include "probador_pcie.v" // Agrega archivo de probador

module pruebas_pcie();

	input wire reset;
	input wire RESET;
  	wire VALID_OUT;
  	input wire [3:0] CONTROL;
	wire CLK;
	wire [7:0] DATA;

  	probador_pcie probador (reset, RESET, CONTROL, CLK, DATA, VALID_OUT); 
  	pcie PCIETest (reset, RESET, CONTROL, 8'hFF, CLK, DATA, VALID_OUT); 

  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;

    	end

endmodule
