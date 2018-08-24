module probador_pcie(reset, RESET, CONTROL, CLK, DATA, VALID_OUT);

	output reg reset;
	output reg RESET;
	output reg [3:0] CONTROL;
	output reg CLK;
	output reg [7:0] DATA;
	output reg VALID_OUT;

	initial begin
		reset = 1;
		RESET = 1;
		CLK = 0;
		DATA <= 0;
		VALID_OUT <= 0;
		CONTROL = 0;

		#3 reset = 0;
		RESET = 0;

		#100 $finish;

	end

	always 
		begin #1 CLK <= ~CLK;
	end

endmodule
