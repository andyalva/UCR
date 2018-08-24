//Proyecto #1 Circuitos Digitales 2//
module bytestripingRX( input clk, reset, valid,
   output reg[7:0] data,
   input [7:0] data_in0, data_in1, data_in2, data_in3);

   reg [7:0] data_next;

//Indice de registro de los 4 estados,
 parameter [4:0] LaneA = 1,
		 LaneB = 2,
		 LaneC = 3,
		 LaneD = 4,
		 Estado0 =5; //Me da la señal para empezar
		
 reg [7:0] state, next_state; // Se le asignan 8 bits para utlizar one-hot.

//Bloque de Flip Flops
 always @(posedge clk or reset)

	if(reset)begin
	  state <= 8'b00000000; 
	  state[LaneA] <= 1'b1;
	  data<=8'b00000000;
	end
	else if(valid) begin 
		state <= next_state;
		data<=data_next;
	end
		

// Bloque de asignacion de los estados y sus transiciones.
 always@(*) begin
	next_state = 8'b00000000;
	data_next=data;  //Evita los Latch inferidos
	case (1'b1)

		state[Estado0]: if(valid) begin next_state [LaneA] = 1'b1;
				
					data_next=data_in0;

			      	end else   next_state [Estado0] = 1'b1;

	
		state[LaneA]: if(valid) begin next_state [LaneB] = 1'b1;
				
					data_next=data_in1;
				
			      end else   next_state [LaneA] = 1'b1;
		
		state[LaneB]: if(valid)begin  next_state [LaneC] = 1'b1;

					data_next=data_in2;			

			      end else   next_state [LaneB] = 1'b1;
		
		state[LaneC]: if(valid) begin next_state [LaneD] = 1'b1;

					data_next=data_in3;

			      end else next_state [LaneC] = 1'b1;
      		
		state[LaneD]: if(valid) begin next_state [LaneA] = 1'b1;

				
					data_next=data_in0;			

			      end else next_state [LaneD] = 1'b1;
	endcase
end
endmodule
