//Proyecto #1 Circuitos Digitales 2//
module bytestripingTX( input clk, reset, valid,
	input [7:0] data,
	output reg [7:0] data_out0, data_out1, data_out2, data_out3);

	reg [7:0] data_out0_next, data_out1_next, data_out2_next, data_out3_next;
	reg [2:0] state, next_state; // Se le asignan 8 bits para utlizar one-hot.

//Bloque de Flip Flops
 always @(posedge clk or reset)

	if(reset)begin
	  state <= 0;
	  next_state <= 0;
	  data_out0<=8'b00000000;
	  data_out1<=8'b00000000;
	  data_out2<=8'b00000000;
	  data_out3<=8'b00000000;
	end
	else if(valid) begin 
		state <= next_state;
		data_out0<=data_out0_next;
		data_out1<=data_out1_next;	//Flops para mantener el dato y evitar latches
		data_out2<=data_out2_next;
		data_out3<=data_out3_next;
	end
		
	always@(*)begin
	data_out0_next=data_out0;  //Evita los Latch inferidos
	data_out1_next=data_out1;
	data_out2_next=data_out2;
	data_out3_next=data_out3;
	end


// Bloque de asignacion de los estados y sus transiciones.
 always@(posedge clk) begin
	if (valid) begin
		case (state)
			0: if(valid) begin next_state = 1;
					
						data_out0_next=data;
					
					end 
			
			1: if(valid) begin next_state = 2;
					
						data_out1_next=data;
					
					end 
			
			2: if(valid)begin  next_state = 3;

						data_out2_next=data;			

					end
			
			3: if(valid) begin next_state = 0;

						data_out3_next=data;

					end 
		endcase
	end
end
endmodule
