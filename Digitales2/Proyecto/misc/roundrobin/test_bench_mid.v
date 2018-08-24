`include "tester_mid.v" // Agrega archivo de codigo
`include "mid.v" // Agrega archivo de codigo


module test_bench_mid();

	wire clk;
	wire [19:0] request;
	wire reset;
	wire [1:0] pop_id;
	wire [3:0] empty;
	wire valid;

  	tester_mid probador (reset, request, pop_id, clk, empty, valid); 
  	mid mid (reset, request, pop_id, clk, empty, valid); 
	
  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;
    		end

endmodule

