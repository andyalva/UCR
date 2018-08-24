module mux_de_control(input [3:0] CONTROL,
                	input 	VALID,
                	input 	[7:0] COM,
                	input 	[7:0] PAD,
			input 	[7:0] SKP,
			input 	[7:0] STP,
			input 	[7:0] SDP,
			input 	[7:0] END,
			input 	[7:0] EDB,
			input 	[7:0] FTS,
			input 	[7:0] IDL,
			input	[7:0] Tx_Buffer,
			input 	CLK,
                        output reg [7:0] OUT);
  
	always @ (posedge CLK) begin // Se activa en flanco positivo del CLK

		case (CONTROL) // Selector de entrada
	  		0: OUT <= COM; //8'hBC
	  		1: OUT <= PAD; //8'hF7
	  		2: OUT <= SKP; //8'h1C
	  		3: OUT <= STP; //8'hFB
	  		4: OUT <= SDP; //8'h5C
	  		5: OUT <= END; //8'hFD
	  		6: OUT <= EDB; //8'hFE
	  		7: OUT <= FTS; //8'h3C
	  		8: OUT <= IDL; //8'h7C
			9: OUT <= Tx_Buffer; //DATA
		endcase
			
	end	
 
endmodule


	  
  

 



	
