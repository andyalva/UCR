`timescale 1ns/100ps

`include "tester.v"
`include "convert.v"
`include "synth.v"

module test_bench # (parameter SIZE=8) ();

   wire 	   wRESET;
   wire 	   wPCLK;
   wire [SIZE-1:0] wDATA_IN;
   wire 	   wBIT_RATE_CLK10;
   wire [15:0] 	   wDATA_OUT;
   wire [1:0]	   wIDLE_BUFFER;


   size_convert_cond # (SIZE) size_convert_cond
     (
      .RESET(wRESET),
      .BIT_RATE_CLK10(wBIT_RATE_CLK10),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN),
      .DATA_OUT(wDATA_OUT[7:0]),
      .IDLE_BUFFER(wIDLE_BUFFER[0])
      );

   size_convert # (SIZE) size_convert0
     (
      .RESET(wRESET),
      .BIT_RATE_CLK10(wBIT_RATE_CLK10),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN),
      .DATA_OUT(wDATA_OUT[15:8]),
      .IDLE_BUFFER(wIDLE_BUFFER[1])
      );

   tester # (SIZE) tester0
     (
      .RESET(wRESET),
      .BIT_RATE_CLK(wBIT_RATE_CLK),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN)
      );


   initial
     begin
	$display("Start simulation...");
        $dumpfile("simulation.vcd");
        $dumpvars();
	#1000 $finish();
	$display("End simulation...");
     end


endmodule // test_bench
