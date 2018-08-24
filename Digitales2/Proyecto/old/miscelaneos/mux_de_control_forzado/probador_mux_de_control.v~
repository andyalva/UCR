module probador_mux_de_control(CONTROL, CLK, VALID, OUT);

	output reg [3:0] CONTROL;
	output reg CLK;
	output reg VALID;
	output reg [7:0] OUT;

	initial begin 
		CONTROL <= 0;
		CLK = 0;
		OUT <= 8'h00;

		#43 CONTROL <= 0;

		#43 CONTROL <= 1;

		#43 CONTROL <= 2;

		#43 CONTROL <= 3;

		#43 CONTROL <= 4;

		#43 CONTROL <= 5;

		#43 CONTROL <= 6;

		#43 CONTROL <= 7;

		#43 CONTROL <= 8;

		#43 CONTROL <= 9;

		#40 $finish;

	end

	always
		begin #20 CLK <= ~CLK;
	end 

endmodule
