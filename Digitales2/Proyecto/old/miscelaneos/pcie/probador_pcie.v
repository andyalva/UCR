module probador_pcie(RESET, reset, CONTROL, CLK, DATA, Valid);

	output reg RESET;
	output reg reset;
	output reg [3:0] CONTROL;
	output reg CLK;
	output reg [7:0] DATA;
	output reg Valid;

	initial begin
		RESET = 1;
		reset = 1;
		CLK = 0;
		DATA = 0;
		#32 reset = 0;
		#32 RESET = 0;


		#47 CONTROL = 0;
		#32 CONTROL = 0;
		#32 CONTROL = 0;
		#32 CONTROL = 0;
		#32 CONTROL = 1;
		#32 CONTROL = 2;
		#32 CONTROL = 3;
		#32 CONTROL = 4;
		#32 CONTROL = 9;
			DATA = 8'hAA;
		#32 CONTROL = 9;
			DATA = 8'hBB;
		#32 CONTROL = 9;
			DATA = 8'hCC;
		#32 CONTROL = 9;
			DATA = 8'hDD;	
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
