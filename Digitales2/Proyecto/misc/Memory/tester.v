
module tester
	(
	output reg [7:0] DATA_IN,
	output reg 	    CLK,
	output reg 	    RESET,
	output reg		WRITE,
	output reg		READ,
	output reg		BIG,
	output reg		Valid
   );

   	initial
    	begin
			CLK = 1;
			BIG = 1;
			Valid = 0;
			RESET = 0;
			WRITE = 0;
			READ = 0;
			@(posedge CLK)
			RESET = 1;
			@(posedge CLK)
			@(posedge CLK)
			RESET = 0;
			@(posedge CLK)
			DATA_IN <= 8'hFF;
			@(posedge CLK)
			WRITE <= 1;
			Valid <= 1;
			DATA_IN <= 8'hAA;
			@(posedge CLK)
			DATA_IN <= 8'hBB;
			@(posedge CLK)
			DATA_IN <= 8'hCC;
			@(posedge CLK)
			DATA_IN <= 8'hDD;
			READ <= 1;
			@(posedge CLK)
			DATA_IN <= 8'hEE;
			@(posedge CLK)
			READ <= 0;
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			READ <= 1;
			DATA_IN <= 8'b10100110;
			@(posedge CLK)
			DATA_IN <= 8'b00111001;
			@(posedge CLK)
			DATA_IN <= 8'b10101000;
			@(posedge CLK)
			READ <= 0;
			DATA_IN <= 8'b11111001;
			@(posedge CLK)
			DATA_IN <= 8'b01001111;
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			READ <= 1;
			DATA_IN <= 8'b11111001;
			@(posedge CLK)
			DATA_IN <= 8'b11111101;
			@(posedge CLK)
			DATA_IN <= 8'b11111111;
			@(posedge CLK)
			DATA_IN <= 8'b11110000;
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			@(posedge CLK)
			WRITE <= 0;
		end

   always
     begin
	#1 CLK <= ~CLK;
     end

endmodule
