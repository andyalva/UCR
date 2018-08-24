module FIFO
	(
	//inputs
	input wire [7:0] DATA_IN,
	input wire 	    CLK,
	input wire 	    RESET,
	input wire		WRITE,
	input wire		READ,
	input wire		BIG,
	//outputs
	output reg [7:0] DATA_OUT,
	output reg		almost_Full,
	output reg		almost_Empty,
	output reg		ErrStackOverflow,
	output reg		ErrNoData,
	output reg		Empty,
	output reg		Full,
	input wire		Valid
	);

    reg [7:0] 	    rCurrentState, rNextState;
    reg [127:0] 	    rBuffer;

	always @(posedge CLK)
		begin
			if(RESET)
				begin
					rCurrentState <= 0;
					rBuffer <= 0;
					almost_Full <= 0;
					almost_Empty <= 0;
					ErrStackOverflow <= 0;
					ErrNoData <= 0;
					Empty <= 0;
					Full <= 0;
				end
			if(Valid)
				begin
					case (rCurrentState)
						0:
							begin
								if(WRITE)
									begin
										rBuffer[7:0] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if (READ)
									begin
										ErrNoData <= 1;
									end
								Empty <= 1;
							end
						1: 
							begin
								if(WRITE && !READ)
									begin
										rBuffer[15:8] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ && !WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ && WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= DATA_IN;
									end
								Empty <=  0;

							end
						2:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[23:16] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
										almost_Empty <= 0;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= DATA_IN;
									end
							end
						3:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[31:24] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= DATA_IN;
									end
								if(!BIG)
									begin
										almost_Full <= 0;
									end
							end
						4:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[39:32] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= DATA_IN;
									end
								almost_Empty <= 0;
							end
						5:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[47:40] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= DATA_IN;
									end
								if(!BIG)
									begin
										almost_Full <= 1;
									end
							end
						6:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[55:48] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= DATA_IN;
									end
							end
						7:
							begin
								if(WRITE&&!READ)
									begin
										rBuffer[63:56] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= DATA_IN;
									end
							end
						8:
							begin
								if(!BIG)
									begin
										if(READ && !WRITE)
											begin
												DATA_OUT <= rBuffer[7:0];
												rBuffer[7:0] <= rBuffer[15:8];
												rBuffer[15:8] <= rBuffer[23:16];
												rBuffer[23:16] <= rBuffer[31:24];
												rBuffer[31:24] <= rBuffer[39:32];
												rBuffer[39:32] <= rBuffer[47:40];
												rBuffer[47:40] <= rBuffer[55:48];
												rBuffer[55:48] <= rBuffer[63:56];
												rCurrentState <= rCurrentState - 1;
											end
										if(READ && WRITE)
											begin
												DATA_OUT <= rBuffer[7:0];
												rBuffer[7:0] <= rBuffer[15:8];
												rBuffer[15:8] <= rBuffer[23:16];
												rBuffer[23:16] <= rBuffer[31:24];
												rBuffer[31:24] <= rBuffer[39:32];
												rBuffer[39:32] <= rBuffer[47:40];
												rBuffer[47:40] <= rBuffer[55:48];
												rBuffer[55:48] <= rBuffer[63:56];
												rBuffer[63:56] <= DATA_IN;
											end
										if(WRITE && !READ)
											begin
												ErrStackOverflow <= 1;
											end
										Full <= 1;
									end
								else
									begin
										if(WRITE&&!READ)
											begin
												rBuffer[71:64] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
										if(READ&&!WRITE)
											begin
												DATA_OUT <= rBuffer[7:0];
												rBuffer[7:0] <= rBuffer[15:8];
												rBuffer[15:8] <= rBuffer[23:16];
												rBuffer[23:16] <= rBuffer[31:24];
												rBuffer[31:24] <= rBuffer[39:32];
												rBuffer[39:32] <= rBuffer[47:40];
												rBuffer[47:40] <= rBuffer[55:48];
												rBuffer[55:48] <= rBuffer[63:56];
												rCurrentState <= rCurrentState - 1;
											end
										if(READ&&WRITE)
											begin
												DATA_OUT <= rBuffer[7:0];
												rBuffer[7:0] <= rBuffer[15:8];
												rBuffer[15:8] <= rBuffer[23:16];
												rBuffer[23:16] <= rBuffer[31:24];
												rBuffer[31:24] <= rBuffer[39:32];
												rBuffer[39:32] <= rBuffer[47:40];
												rBuffer[47:40] <= rBuffer[55:48];
												rBuffer[55:48] <= rBuffer[63:56];
												rBuffer[63:56] <= DATA_IN;
											end
									end
							end
						9:
							begin
								if(WRITE && !READ)
									begin
										rBuffer[79:72] <= DATA_IN;
										rCurrentState <= rCurrentState + 1;
									end
								if(READ&&!WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rCurrentState <= rCurrentState - 1;
									end
								if(READ&&WRITE)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= DATA_IN;
									end
							end

						10:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										if (WRITE)
											begin
												rBuffer[79:72] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[87:80] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
									end
							end

						11:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80]; //11
										if (WRITE)
											begin
												rBuffer[87:80] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[95:88] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
									end
								almost_Full <= 0;
							end

						12:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80];
										rBuffer[87:80] <= rBuffer[95:88]; //12
										if (WRITE)
											begin
												rBuffer[95:88] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[103:96] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
									end
							end


						13:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80];
										rBuffer[87:80] <= rBuffer[95:88]; //12
										rBuffer[95:88] <= rBuffer[103:96];
										if (WRITE)
											begin
												rBuffer[103:96] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[111:104] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
												almost_Full <= 1;
											end
									end
							end


						14:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80];
										rBuffer[87:80] <= rBuffer[95:88]; //12
										rBuffer[95:88] <= rBuffer[103:96];
										rBuffer[103:96] <= rBuffer[111:104];
										if (WRITE)
											begin
												rBuffer[111:104] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[119:112] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
									end
							end

						15:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80];
										rBuffer[87:80] <= rBuffer[95:88]; //12
										rBuffer[95:88] <= rBuffer[103:96];
										rBuffer[103:96] <= rBuffer[111:104];
										rBuffer[111:104] <= rBuffer[119:112];
										if (WRITE)
											begin
												rBuffer[119:112] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												rBuffer[127:120] <= DATA_IN;
												rCurrentState <= rCurrentState + 1;
											end
									end
							end

						16:
							begin
								if(READ)
									begin
										DATA_OUT <= rBuffer[7:0];
										rBuffer[7:0] <= rBuffer[15:8];
										rBuffer[15:8] <= rBuffer[23:16];
										rBuffer[23:16] <= rBuffer[31:24];
										rBuffer[31:24] <= rBuffer[39:32];
										rBuffer[39:32] <= rBuffer[47:40];
										rBuffer[47:40] <= rBuffer[55:48];
										rBuffer[55:48] <= rBuffer[63:56];
										rBuffer[63:56] <= rBuffer[71:64];
										rBuffer[71:64] <= rBuffer[79:72];
										rBuffer[79:72] <= rBuffer[87:80];
										rBuffer[87:80] <= rBuffer[95:88]; //12
										rBuffer[95:88] <= rBuffer[103:96];
										rBuffer[103:96] <= rBuffer[111:104];
										rBuffer[111:104] <= rBuffer[119:112];
										rBuffer[119:112] <= rBuffer[127:120];
										if (WRITE)
											begin
												rBuffer[127:120] <= DATA_IN;
											end

										else
											begin
												rCurrentState <= rCurrentState - 1;
											end
									end
								else
									begin
										if(WRITE)
											begin
												ErrStackOverflow <= 1;
											end
									end
								Full <= 1;
							end

						default:
							begin
								rCurrentState <= 0;
							end
						endcase // casex (woResult)
						
				end
		end

		
endmodule
