module tester
  (
   output reg DATA_IN,
   output reg RESET,
   output reg CLK
   );

   initial
     begin
	CLK = 0;
	RESET = 0;
	#5 RESET = 1;
	#4 RESET = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 0;

	#2 DATA_IN = 1;
	#2 DATA_IN = 1;
	#2 DATA_IN = 1;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 1;


	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;

	#2 DATA_IN = 0;
	#2 DATA_IN = 0;
	#2 DATA_IN = 0;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 0;

	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
	#2 DATA_IN = 0;
	#2 DATA_IN = 1;
     end

   always
     begin
	#1 CLK = ~CLK;
     end

endmodule
