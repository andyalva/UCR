module tester # (parameter SIZE=32)
   (
    output reg 		  BIT_RATE_CLK,
    output reg 		  PCLK,
    output reg [7:0] 	  DATA_IN,
    output reg 		  RESET,
    output reg 		  EQUAL,
    input wire [SIZE-1:0] DATA_OUT0,
    input wire [SIZE-1:0] DATA_OUT1 		  
    );

   initial
     begin
	BIT_RATE_CLK = 1;
	PCLK = 0;
	DATA_IN = 0;
	RESET = 0;
	#3 RESET = 1;
	#5 RESET = 0;
     end

   always @(posedge PCLK)
     begin
	#4 DATA_IN = DATA_IN + 4;	
     end

   always
     begin
	#1 PCLK = ~PCLK;
     end

   always @(DATA_OUT0 or DATA_OUT1)
     begin
	if (DATA_OUT0 == DATA_OUT1)
	  begin
	     EQUAL <= 1;
	  end
	else
	  begin
	     EQUAL <= 0;
	  end
     end

endmodule // tester
