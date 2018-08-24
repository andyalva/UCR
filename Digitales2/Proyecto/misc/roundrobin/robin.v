module roundrobin (	input [3:0] empty,
			output reg [1:0] id,
			input clk);

	reg [5:0] count = 0;

	always @ (posedge clk) begin

		case (count)

			0:
				begin
					id <= mem1 [count];
					count = count + 1;
				end
			1:
				begin
					id <= mem1 [count];
					count = count + 1;
				end
			2:
				begin
					id <= mem1 [count];
					count = count + 1;
				end
			3:
				begin
					id <= mem1 [count];
					count = count + 1;
				end
			default:
				begin
					count = count;
				end
		endcase

		if count()	

	end

endmodule
			