`include "./registro_16b.v"
`include "./probador_16b.v"

module Banco_de_pruebas ();
   
   wire clk;
   wire [15:0] d;
   wire [1:0] mode;
   
  
   Probador t1(clk,enb,dir,s_in,d,mode);
   Registro_16b r1(clk,enb,dir,s_in,d,mode,,);
   
   initial
     begin
	$dumpfile("senales.vcd");
	$dumpvars;
	$display ("Ejecutando simulacion");
	$monitor ($time,,"clk = %b", clk);
	#500 $finish;
     end
endmodule  
