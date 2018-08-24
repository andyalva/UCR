
module parallel_serial_cond
  (
   //inputs
   input wire [7:0] DATA_IN,
   input wire 	    CLK,
   input wire 	    RESET, 
   input wire		Valid,
   //outputs
   output reg 	    DATA_OUT
   );

   reg [2:0] 	    rCurrentState, rNextState;
   reg [7:0] 	    rBuffer;

	always @(posedge CLK)
		begin
			if ( RESET)				
				begin
					rCurrentState <= 0;
				end
		end
			
	always @(posedge CLK)
		begin
			if(Valid)
				begin
					case (rCurrentState)
						0:
							begin
								rBuffer <= DATA_IN;
								DATA_OUT <= DATA_IN[7];
								rCurrentState <= 1;
							end
						1: 
							begin
								DATA_OUT <= rBuffer[6];
								rCurrentState <= 2;
							end
						2:
							begin
								DATA_OUT <= rBuffer[5];
								rCurrentState <= 3;
							end
						3:
							begin
								DATA_OUT <= rBuffer[4];
								rCurrentState <= 4;
							end
						4:
							begin
								DATA_OUT <= rBuffer[3];
								rCurrentState <= 5;
							end
						5:
							begin
								DATA_OUT <= rBuffer[2];
								rCurrentState <= 6;
							end
						6:
							begin
								DATA_OUT <= rBuffer[1];
								rCurrentState <= 7;
							end
						7:
							begin
								DATA_OUT <= rBuffer[0];
								rCurrentState <= 0;
							end
						default:
							begin
								rCurrentState <= 0;
							end
					endcase // casex (woResult)
				end
		end

		
endmodule
