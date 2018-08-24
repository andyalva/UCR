module probador_pcie(RESET, CLK, DATA, Valid);

	output reg RESET;
	output reg CLK;
	output reg [7:0] DATA;
	output reg Valid;

	initial begin
		RESET = 1;
		CLK = 0;
		DATA <= 0;
		#3 RESET = 0;
		Valid = 1;

		#16 DATA = 8'b00100101;
		#16 DATA = 8'b10111100; //BC
		#16 DATA = 8'b11111001;
		#16 DATA = 8'b01001111;
		#16 DATA = 8'b10100110;
		#16 DATA = 8'b00111001;
		#16 DATA = 8'b10101000;
		#16 DATA = 8'b11111001;
		#16 DATA = 8'b01001111;

		#100 $finish;

	end

	always 
		begin #1 CLK <= ~CLK;
	end

endmodule
