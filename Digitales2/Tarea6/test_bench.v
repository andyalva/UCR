`timescale 1ns/100ps

`include "ascensor.v"
`include "tester.v"
//`include "synth.v"

module testbench ();

   //Se definen inputs:
   wire CLK;
   wire [1:0] Signal;

   //Se definen outputs:
   wire       Floor0, Floor1, wRESET;

   tester prob
     (
      .CLK(CLK),
      .Signal(Signal),
      .RESET(wRESET)
      );


   ascensor uut_cond
     (
      .CLK(CLK),
      .Signal(Signal),
      .RESET(wRESET),
      .Floor(Floor1)
      );
      

   initial
     begin
	//For GTKWave usage.
	$dumpfile("simulation.vcd");
	$dumpvars();
	#1000 $finish();
     end

endmodule
