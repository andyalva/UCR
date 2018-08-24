`timescale 1ns/100ps

`include "serial_parallel.v"
`include "tester.v"
//`include "synth.v"

module testbench ();

   wire  CLK, DATA_IN, wRESET;
   wire [7:0] DATA_OUT [0:1];

   tester prob 
     (
      .CLK(CLK),
      .RESET(wRESET),
      .DATA_IN(DATA_IN)
      );

/*   serial_parallel uut_estr
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .DATA_OUT(DATA_OUT[0])
      );
*/
   serial_parallel_cond uut_cond
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .DATA_OUT(DATA_OUT[1])
      );

   initial
     begin
	$dumpfile("simulation.vcd");
	$dumpvars();
	#1000 $finish();
     end

endmodule
