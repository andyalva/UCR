module ascensor
  (
   //inputs
   input wire [1:0]	Signal,
   input wire 	    CLK,
   input wire 	    RESET, 
   //outputs
   output reg 	    Floor
   );

   reg [2:0] 	    rCurrentState, rNextState;

	always @(posedge CLK)
		begin
			if (RESET)				
				begin
					rCurrentState <= 0;
					Floor <= 0;
				end
			else
				begin
					rCurrentState <= rNextState;
				end
		end
			
	always @(negedge CLK) //Signal: 2 subir, 1 bajar, 0 halt
		begin
				begin
					case (rCurrentState)
						0: //Idle
							begin
								if(Signal==2)
									begin
										rNextState <= 3;
									end
								if(Signal == 1)
									begin
										rNextState <= 4;
									end
								else
									begin
										rNextState <= rNextState;
									end
							end
						1: //Primer piso
							begin
								Floor <= 0;
								if (Signal == 2)
									begin
										rNextState <= 3;
									end
								else
									begin
										rNextState <= rNextState;
									end
							end
						2: //Segudno piso
							begin
								Floor <= 1;
								if (Signal == 1)
									begin
										rNextState <= 4;
									end
								else
									begin
										rNextState <= rNextState;
									end
							end
						3: //Going Up
							begin
								if (Signal == 0)
									begin
										rNextState <= 0;
									end
								else
									begin
										rNextState <= 2;
									end
							end
						4: //Going down
							begin
								if (Signal == 0)
									begin
										rNextState <= 0;
									end
								else
									begin
										rNextState <= 1;
									end
							end
						default:
							begin
								rNextState <= 0;
							end
					endcase // casex (woResult)
				end
		end

		
endmodule
