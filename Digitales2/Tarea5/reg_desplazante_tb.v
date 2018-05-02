`timescale 1ns/100ps
`include "synth.v"
`include "probador.v"


module reg_desplazante_tb ();

   //uut inputs
   wire CLK;
   wire ENB;
   wire DIR;
   wire S_IN;
   wire [1:0] MODO;
   wire [3:0] D;

   //uut outputs
   wire [3:0] Q;
   wire       S_OUT;


   probador prob (
		  .CLK(CLK),
		  .ENB(ENB),
		  .DIR(DIR),
		  .S_IN(S_IN),
		  .MODO(MODO),
		  .D(D)
		  );

   //Instantiate the unit under test
   reg_desplazante uut (
			.CLK(CLK),
			.ENB(ENB),
			.DIR(DIR),
			.S_IN(S_IN),
			.MODO(MODO),
			.D(D),
			.Q(Q),
			.S_OUT(S_OUT)
			);

   initial
     begin
	$dumpfile("reg_desplazante.vcd");
	$dumpvars();
	#1500 $finish;
     end


   always @ (posedge CLK)
     begin
	$monitor("At time %t, Q = %4b, S_OUT = %b ", $time, Q, S_OUT);
     end

endmodule // reg_desplazante_tb
