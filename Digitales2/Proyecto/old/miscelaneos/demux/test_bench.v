`timescale 1ns/100ps

`include "demux.v" // Agrega archivo de codigo
`include "probador_demux.v" // Agrega archivo de probador

module pruebas_demux();

	input wire VALID;
	input wire CLK;
	wire VALID_OUT;
  	wire [7:0] DATA;
  	input wire [7:0] Rx_buffer;

  	probador_demux probador (Rx_buffer, CLK, VALID, VALID_OUT, DATA); 
  	demux demux (Rx_buffer, CLK, VALID, VALID_OUT, DATA); 

  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;

    	end

endmodule
