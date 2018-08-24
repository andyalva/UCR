`include "tester.v" // Agrega archivo de codigo
`include "qos.v" // Agrega archivo de codigo


module test_bench();

	wire CLK;
	wire [19:0] request;
	wire RESET;
	wire init;
	wire [7:0] DATA_IN;
	wire [7:0] DATA_OUT;
	wire WRITE;
	wire read;
	wire BIG;


  	tester probador (DATA_IN, CLK, RESET, WRITE, BIG, init, request, read, DATA_OUT); 
  	qos qos (DATA_IN, CLK, RESET, WRITE, BIG, init, request, read, DATA_OUT); 
	
  	initial
    		begin
      			$dumpfile("simulation.vcd");
      			$dumpvars;
    		end

endmodule

