module probador_pcie(RESET, reset, CLK, DATA, Valid);

	output reg RESET;
	output reg reset;
	output reg CLK;
	output reg [7:0] DATA;
	output reg Valid;

	initial begin
		RESET = 1;
		Valid = 0;
		reset = 1;
		CLK = 0;
		DATA <= 0;
		#32 reset = 0;
		#32 RESET = 0;
		reset = 0;


		#47 DATA = 8'b00100101;
		#32 DATA = 8'b10111100; //BC
			Valid = 1;
		#32 DATA = 8'b10111100; //BC
		#32 DATA = 8'b10111100; //BC
		#32 DATA = 8'b10111100; //BC
		#32 DATA = 8'b11111001;
		#32 DATA = 8'b01001111;
		#32 DATA = 8'b10100110;
		#32 DATA = 8'b00111001;
		#32 DATA = 8'b10101000;
		#32 DATA = 8'b11111001;
		#32 DATA = 8'b01001111;

		#500 $finish;

	end

	always 
		begin #1 CLK <= ~CLK;
	end

endmodule
