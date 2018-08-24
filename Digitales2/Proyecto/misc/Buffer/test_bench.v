`timescale 1ns/100ps

`include "FIFO.v"
`include "tester.v"
//`include "synth.v"

module testbench ();

   //Se definen inputs:
   wire CLK;
   wire [7:0] DATA_IN;
   wire Valid;
   wire [7:0] DATA_OUT;

   //Se definen outputs:
   wire       DATA_OUT0, DATA_OUT1, wRESET, WRITE, READ, BIG;

   tester prob
     (
      .CLK(CLK),
      .DATA_IN(DATA_IN),
      .RESET(wRESET),
      .WRITE(WRITE),
      .READ(READ),
      .BIG(BIG),
      .Valid(Valid)
      );

   FIFO uut_cond
     (
      .DATA_IN(DATA_IN),
      .CLK(CLK),
      .RESET(wRESET),
      .WRITE(WRITE),
      .READ(READ),
      .BIG(BIG),
      .Valid(Valid)
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
