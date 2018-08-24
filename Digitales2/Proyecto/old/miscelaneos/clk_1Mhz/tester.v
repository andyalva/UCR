module tester
  (
   output reg 	    CLK,
   output reg 	    RESET
   );

   initial
     begin
	CLK = 1;
	RESET = 0;
	#3 RESET = 1;
	#9 RESET = 0;
     end

   always
     begin
	#1 CLK = ~CLK;
     end

endmodule
