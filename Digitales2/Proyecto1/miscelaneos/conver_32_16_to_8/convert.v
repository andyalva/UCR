
module size_convert_cond # (parameter SIZE=8)
   (
    //input
    input wire 		  RESET,
    input wire 		  BIT_RATE_CLK10,
    input wire 		  PCLK,
    input wire [SIZE-1:0] DATA_IN,
    //output
    output reg [7:0] 	  DATA_OUT,
    output reg 		  IDLE_BUFFER
    );

   reg [1:0] 		  rCurrentState, rNextState;
   reg [SIZE-1:0] 	  rBuffer;


   always @(posedge PCLK)
     begin
	if (RESET)
	  begin
	     rCurrentState <= 0;
	  end
	else
	  begin
	     rCurrentState <= rNextState;
	  end
     end


   always @(negedge PCLK)
     begin

        if (SIZE == 8)
          begin
	     casex (rCurrentState)
	       0:
		 begin
		    DATA_OUT <= DATA_IN;
		    IDLE_BUFFER <= 1;
		    rNextState <= 0;
		 end
               default:
                 begin
                    IDLE_BUFFER <= 1;
		    rNextState <= 0;
                 end
	     endcase // casex (rCurrentState)
	  end // if (SIZE == 8)

        else if (SIZE == 16)
          begin
             casex (rCurrentState)
               0:
                 begin
                    DATA_OUT <= DATA_IN[7:0];
		    rBuffer <= DATA_IN;
                    IDLE_BUFFER <= 0;
		    rNextState <= 1;
                 end
               1:
                 begin
                    DATA_OUT <= rBuffer[15:8];
                    IDLE_BUFFER <= 1;
		    rNextState <= 0;
                 end
               default:
                 begin
                    IDLE_BUFFER <= 1;
		    rNextState <= 0;
                 end
             endcase // casex (oResult)
          end // if (SIZE == 16)

        else if (SIZE == 32)
          begin
             casex (rCurrentState)
               0:
                 begin
                    DATA_OUT <= DATA_IN[7:0];
		    rBuffer <= DATA_IN;
                    IDLE_BUFFER <= 0;
		    rNextState <= 1;
                 end
               1:
                 begin
                    DATA_OUT <= rBuffer[15:8];
                    IDLE_BUFFER <= 0;
		    rNextState <= 2;
                 end
               2:
                 begin
                    DATA_OUT <= rBuffer[23:16];
                    IDLE_BUFFER <= 0;
		    rNextState <= 3;
                 end
               3:
                 begin
                    DATA_OUT <= rBuffer[31:24];
                    IDLE_BUFFER <= 1;
		    rNextState <= 0;
                 end
               default:
                 begin
                    IDLE_BUFFER <= 1;
		    rNextState <= 0;
                 end
             endcase // casex (oResult)
          end

        else
          begin
             IDLE_BUFFER <= 1;
	     rNextState <= 0;
          end // else: !if(SIZE == 32|16|8)
     end
endmodule // size_convert
