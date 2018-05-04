`timescale 1ns/100ps

`include "tester.v"
`include "convert.v"
`include "synth.v"

module test_bench # (parameter SIZE=8) ();

   wire wPCLK, wRESET;
   wire [7:0] wDATA_IN;
   wire       wBIT_RATE_CLK10, wEQUAL;
   wire [SIZE-1:0] wDATA_OUT [0:1];
   wire [1:0] 	   wIDLE_BUFFER;

   
   size_convert_cond # (SIZE) size_convert_cond0
     (
      .RESET(wRESET),
      .BIT_RATE_CLK10(wBIT_RATE_CLK10),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN),
      .DATA_OUT(wDATA_OUT[0]),
      .IDLE_BUFFER(wIDLE_BUFFER[0])
      );

   size_convert # (SIZE) size_convert0
     (
      .RESET(wRESET),
      .BIT_RATE_CLK10(wBIT_RATE_CLK10),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN),
      .DATA_OUT(wDATA_OUT[1]),
      .IDLE_BUFFER(wIDLE_BUFFER[1])
      );

   tester # (SIZE) tester0
     (
      .BIT_RATE_CLK(wBIT_RATE_CLK),
      .PCLK(wPCLK),
      .DATA_IN(wDATA_IN),
      .RESET(wRESET),
      .EQUAL(wEQUAL),
      .DATA_OUT1(wDATA_OUT[1]),
      .DATA_OUT0(wDATA_OUT[0])
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
