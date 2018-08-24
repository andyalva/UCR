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

		end

	always @(posedge CLK)
		begin

			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;//F
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;//7

			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1; //B
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0; //C


			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;//3
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;//D

			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0;//0
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 0;//C

			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;//5
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;
			#2 DATA_IN <= 0;
			#2 DATA_IN <= 1;//5
		end

   	always
    	begin
			#1 CLK = ~CLK;
		end

endmodule
