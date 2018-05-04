
module tester
  (
   output reg [9:0] DATA_IN,
   output reg 	    CLK,
   output reg 	    RESET
   );

   initial
     begin
	CLK = 1;
	RESET = 0;
	#3 RESET = 1;
	#3 RESET = 0;
	#20 DATA_IN = 10'b0010010101;
	#20 DATA_IN = 10'b0010101000;
	#20 DATA_IN = 10'b1100111001;
	#20 DATA_IN = 10'b0101001111;
	#20 DATA_IN = 10'b1010100110;
	#20 DATA_IN = 10'b1100111001;
	#20 DATA_IN = 10'b0010101000;
	#20 DATA_IN = 10'b1100111001;
	#20 DATA_IN = 10'b0101001111;
     end

   always
     begin
	#1 CLK = ~CLK;
     end

endmodule
