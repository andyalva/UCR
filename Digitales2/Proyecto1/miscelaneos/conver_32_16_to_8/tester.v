module tester # (parameter SIZE=16)
   (
    output reg 		  RESET,
    output reg 		  BIT_RATE_CLK,
    output reg 		  PCLK,
    output reg [SIZE-1:0] DATA_IN
    );

   initial
     begin
	BIT_RATE_CLK = 1;
	PCLK = 0;
	DATA_IN = 0;
	RESET = 0;
	#3 RESET = 1;
	#3 RESET = 0;
     end

   always
     begin
	#8 DATA_IN = DATA_IN + 243352454;
     end

   always
     begin
	#1 PCLK = ~PCLK;
     end

endmodule // tester
