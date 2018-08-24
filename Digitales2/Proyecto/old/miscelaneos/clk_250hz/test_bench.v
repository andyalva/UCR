`timescale 1ns/100ps

`include "clk_250hz.v"
`include "tester.v"
//`include "synth.v"

module testbench ();

   //Se definen inputs:
   wire CLK;

   //Se definen outputs:
   wire       CLK_slow, wRESET;

   tester prob
     (
      .CLK(CLK),
      .RESET(wRESET)
      );

   CLK_250hz_cond uut_cond
     (
      .CLK(CLK),
      .RESET(wRESET),
      .CLK_250hz(CLK_slow)
      );

   /*parallel_serial uut_estr
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .DATA_OUT(DATA_OUT1)
      );
*/
   initial
     begin
	//For GTKWave usage.
	$dumpfile("simulation.vcd");
	$dumpvars();
	#1000 $finish();
     end

endmodule
