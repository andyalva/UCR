`include "define_file.v"

module mux_de_control_forzado(
			input [3:0] CONTROL,
            output reg 	VALID,
			input	[7:0] Tx_Buffer,
			input 	CLK,
            output reg [7:0] OUT);
  
	always @ (posedge CLK) begin // Se activa en flanco positivo del CLK

		case (CONTROL) // Selector de entrada
	  		0: OUT <= `COM; //COM
	  		1: OUT <= `PAD; //PAD
	  		2: OUT <= `SKP; //SKP
	  		3: OUT <= `STP; //STP
	  		4: OUT <= `SDP; //SDP
	  		5: OUT <= `END; //END
	  		6: OUT <= `EDB; //EDB
	  		7: OUT <= `FTS; //FTS
	  		8: OUT <= `IDL; //IDL
			9: OUT <= Tx_Buffer; //DATA
			default: OUT <= 0;
		endcase
	end	

	always @ (posedge CLK) begin

		if (CONTROL == 0)

			VALID = 1;

		else

			VALID = VALID;

	end
 
endmodule
