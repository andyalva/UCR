module probador_mux_de_control_forzado(CONTROL, CLK, VALID, OUT);

	output reg [3:0] CONTROL;
	output reg CLK;
	output reg VALID;
	output reg [7:0] OUT;

	initial begin 
		CONTROL <= 0;
		CLK = 0;
		OUT <= 8'h00;

		#40 CONTROL <= 1;

		#40 CONTROL <= 2;

		#40 CONTROL <= 3;

		#40 CONTROL <= 4;

		#40 CONTROL <= 5;

		#40 CONTROL <= 6;

		#40 CONTROL <= 7;

		#40 CONTROL <= 8;

		#40 CONTROL <= 9;

		#40 $finish;

	end

	always
		begin #20 CLK <= ~CLK;
	end 

endmodule
