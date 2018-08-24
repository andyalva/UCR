`include "byte_stripingRx.v"
module bpbs ( output reg clk, reset, valid,
    input [7:0] data,
   output reg [7:0] data_in0, data_in1, data_in2, data_in3);

   initial
     begin	
	reset=1;
	clk=0;
	valid=0;
	data_in0 <= 8'h00;
	data_in1 <= 8'h00;
	data_in2 <= 8'h00;
	data_in3 <= 8'h00;
	#5;
	@(posedge clk);
	reset <=0;
	@(posedge clk);
	valid<=1;
	#10;
	@(posedge clk);
	data_in0 <= 8'h01;
	@(posedge clk);
	data_in1<= 8'h02;
	@(posedge clk);
	data_in2 <= 8'h03;
	@(posedge clk);
	data_in3 <= 8'h04;
	@(posedge clk);
	data_in0 <= 8'h05;
	@(posedge clk);
	data_in1<= 8'h06;
	@(posedge clk);
	data_in2 <= 8'h07;
	@(posedge clk);
	data_in3 <= 8'h08;
	@(posedge clk);
	data_in0 <= 8'h09;
	@(posedge clk);
	data_in1<= 8'h10;
	@(posedge clk);
	data_in2 <= 8'h11;
	@(posedge clk);
	data_in3 <= 8'h12;

     end

   always
     begin
	#5 clk = ~clk;	
	
     end

endmodule
