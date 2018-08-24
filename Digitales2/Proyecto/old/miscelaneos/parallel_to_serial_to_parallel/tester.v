
module tester
  (
   output reg [7:0] DATA_IN,
   output reg 	    CLK,
   output reg 	    RESET,
	 output reg				Valid
   );

   initial
     begin
	CLK = 1;
	Valid = 0;
	RESET = 0;
	#3 RESET = 1;
	#9 RESET = 0;
	#16 DATA_IN = 8'b00100101;
	#16 DATA_IN = 8'b00101000;
	Valid = 1'b1;
	#16 DATA_IN = 8'b11111001;
	#16 DATA_IN = 8'b01001111;
	#16 DATA_IN = 8'b10100110;
	#16 DATA_IN = 8'b00111001;
	#16 DATA_IN = 8'b10101000;
	#16 DATA_IN = 8'b11111001;
	#16 DATA_IN = 8'b01001111;
     end

   always
     begin
	#1 CLK = ~CLK;
     end

endmodule
