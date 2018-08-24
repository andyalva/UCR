//Proyecto #2 Circuitos Digitales 2//
module FSM( input clk, reset, init, almost_full, almost_empty, empty_Fifo, no_empty_Fifo, Fifo_overflow,
	output reg [3:0] error_full, pausa, continua,
	input [7:0] data_Fifo);
	
	reg [5:0] state, next_state;
	
	reg [7:0] error_full_next, pausa_next, continua_next; //Evitar Latches

//Indice de registro de los 6 estados,
 parameter [5:0] Estado_Reset = 0,
		 Idle = 1,
		 Active = 2,
		 Pause = 3,
		 Continue =4,
		 Error = 5;

//Bloque de Flip Flops
 	always @(posedge clk) begin
	if(reset)begin
	  state <= 6'b1;
	  error_full_next <= 4'b0;
	  pausa_next <= 4'b0;
	  continua_next <= 4'b0;
	
	end else if(init) begin 
	  state <= next_state;  //evitar latches
	  error_full<=error_full_next;
	  pausa<= pausa_next;
	  continua<= continua_next;
		
	end
		end	

// Bloque de asignacion de los estados y sus transiciones.
 always@(*) begin
	next_state = 6'b0;
	error_full_next = error_full; //SIN LATCHES
	pausa_next = pausa;
	continua_next = continua;
	
	case (1'b1)

		state[Estado_Reset]: if(init && empty_Fifo) begin next_state [Idle] = 1'b1;				


			      	end else if(init && no_empty_Fifo) begin  next_state [Active] = 1'b1;
					
			end else begin next_state [Estado_Reset] = 1'b1;
				end
	
					
		state[Idle]: if(init && no_empty_Fifo) begin next_state [Active] = 1'b1;

										
				
			      end else begin  next_state [Idle] = 1'b1;

						
				end
		
		state[Active]: if(init && almost_full)begin  next_state [Pause] = 1'b1;
			
						pausa_next=data_Fifo;

			      end else if(init && almost_empty) begin  next_state [Continue] = 1'b1;

						continua_next=data_Fifo;

					end else if(init && Fifo_overflow) begin next_state [Error] = 1'b1;

						error_full_next=data_Fifo;

					end else begin next_state [Active] = 1'b1;
						end
		
		state[Pause]: if(init)  begin next_state [Active] = 1'b1;
				
					end else begin next_state [Pause] = 1'b1;
						end
					
      		
		state[Continue]: if(init) begin next_state [Active] = 1'b1;
		
					end else begin next_state [Continue] = 1'b1;
							end	
				
		state[Error]: if(reset) begin next_state [Estado_Reset] = 1'b1;

					end else begin next_state [Error] = 1'b1;
						end
	endcase
end
endmodule
