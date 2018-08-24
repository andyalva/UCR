`include "define_file.v"

module probador_demux(Rx_buffer, CLK, VALID, VALID_OUT, DATA);

	output reg [7:0] Rx_buffer;
	output reg CLK;
	output reg VALID_OUT;
	output reg VALID;
	output reg [7:0] DATA;

	initial begin 
		Rx_buffer <= 0;
		CLK = 0;
		DATA <= 8'h00;
		VALID = 0;

		#10 VALID = 1;

		#40 Rx_buffer <= `COM;

		#40 Rx_buffer <= `PAD;

		#40 Rx_buffer <= `SKP;

		#40 Rx_buffer <= `STP;

		#40 Rx_buffer <= `SDP;

		#40 Rx_buffer <= `END;

		#40 Rx_buffer <= `EDB;

		#40 Rx_buffer <= `FTS;

		#40 Rx_buffer <= `IDL;

		#40 Rx_buffer <= 8'hFF;

		#40 $finish;

	end

	always
		begin #20 CLK <= ~CLK;
	end 

endmodule
