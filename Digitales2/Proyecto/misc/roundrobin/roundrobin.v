module roundrobin(	input reset,
		input [19:0] request,
		output reg [1:0] pop_id,
		input clk,
		input valid,
		input [3:0] empty,
		output reg read); 

	reg [1:0] mem1 [0:9];
	integer index;
	integer aux;
	integer count = 0;

	always @ (posedge clk) begin

		if (reset != 0) begin

			for (index = 0; index < 11; index = index + 1) begin

				mem1 [index] <= (request[index * 2] << 1) + request[index * 2 + 1];
			end

		end

		if (reset == 0 && valid) begin

			aux = mem1[count];

			if (count == 9)
				count <= 0;

			case (count)

				0:
					begin	
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				1:	
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				2:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				3:
					begin	
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				4:
					begin	
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				5:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				6:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				7:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				8:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end	
				9:
					begin
						if (empty[aux] == 0) begin
							pop_id <= mem1 [count];
							count = count + 1;
							read = 1;
						end
						else begin
							count = count + 1;
							read = 0;
						end
					end
				default:
					begin
						count = count;
					end
			endcase

		end
	
	end

endmodule