
module size_convert_cond # (parameter SIZE=8)
   (
    //input
    input wire 		  RESET,
    input wire 		  BIT_RATE_CLK10,
    input wire 		  PCLK,
    input wire [7:0] 	  DATA_IN,
    //output
    output reg [SIZE-1:0] DATA_OUT,
    output reg 		  IDLE_BUFFER
    );

   reg [1:0] 		  rCurrentState, rNextState;
   reg [SIZE-9:0] 	  rBuffer;


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
		    DATA_OUT <= DATA_OUT;
		    rBuffer <= DATA_IN;
		    IDLE_BUFFER <= 0;
		    rNextState <= 1;
		 end
	       1: 
		 begin
		    DATA_OUT <= {rBuffer, DATA_IN};
		    IDLE_BUFFER <= 1;
		    rNextState <= 0;
		 end
	       default:
		 begin
		    IDLE_BUFFER <= 1;
		    rNextState <= 0;
		 end	    
	     endcase // casex (i)
	  end // if (SIZE == 16)

	else if (SIZE == 32)
	  //RESET = 0;
	  //#3 RESET = 1;
	  //#5 RESET = 0;
	  //#4 DATA_IN = DATA_IN + 4;
	  begin
	     casex (rCurrentState) 
	       0: 
		 begin
		    DATA_OUT <= DATA_OUT;
		    rBuffer[7:0] <= DATA_IN;
		    IDLE_BUFFER <= 0;
		    rNextState <= 1;
		 end
	       1: 
		 begin
		    DATA_OUT <= DATA_OUT;
		    rBuffer[15:8] <= DATA_IN;
		    IDLE_BUFFER <= 0;
		    rNextState <= 2;
		 end
	       2: 
		 begin
		    DATA_OUT <= DATA_OUT;
		    rBuffer[23:16] <= DATA_IN;
		    IDLE_BUFFER <= 0;
		    rNextState <= 3;
		 end
	       3:
		 begin
		    DATA_OUT <= {DATA_IN, rBuffer};
		    IDLE_BUFFER <= 1;
		    rNextState <= 0;
		 end
	       default: 
		 begin
		    rNextState <= 0;
		    IDLE_BUFFER <= 1;
		 end
	     endcase // casex (i)
	     
	  end

	else
	  begin
	     rNextState <= 0;
	     IDLE_BUFFER <= 1;
	  end // else: !if(SIZE == 32|16|8)
     end
endmodule // size_convert
