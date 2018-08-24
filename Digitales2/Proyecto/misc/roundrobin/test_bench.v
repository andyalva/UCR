`include "tester.v" // Agrega archivo de codigo
`include "roundrobin.v" // Agrega archivo de codigo


module test_bench();

	wire clk;
	wire [19:0] request;
	wire reset;
	wire valid;
	wire [1:0] pop_id;
	wire [3:0] empty;
	wire read;

  	tester probador (reset, request, pop_id, clk, valid, empty, read); 
  	roundrobin roundrobin (reset, request, pop_id, clk, valid, empty, read); 
	
  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;
    		end

endmodule

