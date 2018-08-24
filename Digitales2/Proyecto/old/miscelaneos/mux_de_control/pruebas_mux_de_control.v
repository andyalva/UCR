`include "mux_de_control_forzado.v" // Agrega archivo de codigo
`include "mux_de_control.v" // Agrega archivo de codigo
`include "probador_mux_de_control.v" // Agrega archivo de probador
`include "cmos_cells.v"

module pruebas_mux_de_control();

	wire VALID;
	wire CLK;
  	wire [7:0] OUT;
  	input wire [3:0] CONTROL;

  	probador_mux_de_control probador (CONTROL, CLK, VALID, OUT); 
  	mux_de_control_forzado muxDeControlForzado (CONTROL, VALID, 8'hFF, CLK, OUT); 
	mux_de_control muxDeControl (CONTROL, VALID, 8'hBC, 8'hF7, 8'h1C, 8'hFB, 8'h5C, 8'hFD, 8'hFE, 8'h3C, 8'h7C, 8'hFF, CLK, OUT);

  	initial
    		begin
      			$dumpfile("pruebas_mux_de_control.vcd");
      			$dumpvars;

    	end

endmodule
