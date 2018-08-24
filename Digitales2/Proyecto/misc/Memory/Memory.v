module Memory
	(
	//inputs
	input wire [7:0] DATA_IN,
	input wire 	    CLK,
	input wire 	    RESET,
	input wire		WRITE,
	input wire		READ,
	//outputs
	output reg [7:0] DATA_OUT,
	output reg		almost_Full,
	output reg		almost_Empty,	
	output reg		errNoData,
	output reg		errOverflow,
	input wire		Valid
	);

    reg [7:0] 	    Memory[8];
	reg	[2:0]		indexW;
	reg	[2:0]		indexR;
	integer			positionR;
	integer			positionW;
	integer			index;
			

	always @(posedge CLK)
		begin
			if(RESET)
				begin
					for(index = 0; index <9; index = index+1)
					Memory[index] <= index;
					errNoData <= 0;
					errOverflow <= 0;
					positionR <= 0;
					positionW  <= 0;
					indexR <= 0;
					indexW <= 0;
				end
		end


	always @(posedge CLK)
		begin
			if(READ)
				begin
					DATA_OUT <= Memory[indexR];
					positionR <= positionR + 1;
					if(indexR == 8)
						begin
							indexR <= 0;
						end
					else
						begin
							if(indexR < 3)
									begin
										almost_Empty <= 1;
									end
								else
									begin
										almost_Empty <= 0;
									end
							indexR <= indexR + 1;
						end
				end
			if(WRITE)
				begin
					Memory[indexW] <= DATA_IN;
					positionW <= positionW + 1;
						if(indexW == 8)
							begin
								indexW <= 0;
							end
						else
							begin
								if(indexW > 6)
									begin
										almost_Full <= 1;
									end
								else
									begin
										almost_Full <= 0;
									end
								indexW <= indexW + 1;
							end
				end
			if(positionR > positionW)
				begin
					errNoData <= 1;
				end
			if(positionW > (positionR + 8))
				begin
					errOverflow <= 1;
				end

		end



endmodule
