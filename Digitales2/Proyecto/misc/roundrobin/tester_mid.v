module tester_mid(reset, request, pop_id, clk, empty, valid);

output reg [19:0] request;
output reg clk;
output reg reset;
output reg [1:0] pop_id;
output reg [3:0] empty;
output reg valid;

   initial
     begin
	clk = 1;
	request = 20'b11001110000110111001;
	reset = 1;
	empty = 4'b0000;
	pop_id = 2'b00;
	valid = 0;
	#4 reset = 0;
	#10 empty = 4'b1111;
	#40;
	$display ("mem1[0] = %b", mid.mem1[0]);
	$display ("mem1[1] = %b", mid.mem1[1]);
	$display ("mem1[2] = %b", mid.mem1[2]);
	$display ("mem1[3] = %b", mid.mem1[3]);
	$display ("mem1[4] = %b", mid.mem1[4]);
	$display ("mem1[5] = %b", mid.mem1[5]);
	$display ("mem1[6] = %b", mid.mem1[6]);
	$display ("mem1[7] = %b", mid.mem1[7]);
	$display ("mem1[8] = %b", mid.mem1[8]);
	$display ("mem1[9] = %b", mid.mem1[9]);
	#20 empty = 4'b0000;
	#100 $finish;
     end

   always
     begin
	#1 clk = ~clk;
     end

endmodule
