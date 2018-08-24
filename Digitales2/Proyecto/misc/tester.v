module tester(DATA_IN, CLK, RESET, WRITE, BIG, init, request, read, DATA_OUT);

output reg [19:0] request;
output reg CLK;
output reg RESET;
output reg init;
output reg [7:0] DATA_IN;
output reg WRITE;
output reg read;
output reg BIG;
output reg [7:0] DATA_OUT;

 	initial
    	begin
			CLK = 1;
			request = 20'b11001110000110111001;
			RESET = 1;
			DATA_IN = 8'b00001111;
			init = 0;
			BIG = 0;
			read = 0;
			WRITE = 0;
			DATA_OUT = 8'b00000000;
			#4 init = 1;
			RESET = 0;
			#2 init = 0;
			#100 $finish;
    	end

   always
     begin
		#1 CLK = ~CLK;
     end

endmodule
