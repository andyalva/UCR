`timescale 1ns/100ps

`include "parallel_serial.v"
`include "tester.v"
`include "synth.v"

module testbench ();

   //Se definen inputs:
   wire CLK;
   wire [9:0] DATA_IN;

   //Se definen outputs:
   wire       DATA_OUT0, DATA_OUT1, wRESET;

   tester prob
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET)
      );

   parallel_serial_cond uut_cond
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .DATA_OUT(DATA_OUT0)
      );

   parallel_serial uut_estr
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .DATA_OUT(DATA_OUT1)
      );

   initial
     begin
	//For GTKWave usage.
	$dumpfile("simulation.vcd");
	$dumpvars();
	#1000 $finish();
     end

endmodule
