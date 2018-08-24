`include "define_file.v"

module demux(input [7:0] Rx_buffer,
                	input 	CLK,
                	input 	VALID,
			output reg VALID_OUT,
                        output reg [7:0] DATA);
  
	always @ (posedge CLK) begin

		if (VALID)

			if (Rx_buffer == `STP || Rx_buffer == `SDP || Rx_buffer == `END || Rx_buffer == `IDL || Rx_buffer == `PAD)

				begin
					VALID_OUT <= 0;
					DATA <= DATA;
				end

			else 
	
				begin
					VALID_OUT <= 1;
					DATA <= Rx_buffer;
				end

		else

			DATA = DATA;
 
	end

endmodule


	  
  

 



	
