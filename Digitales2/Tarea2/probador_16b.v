module Probador (
		 output reg 	  CLK,
		 output reg 	  ENB,
		 output reg 	  DIR,
		 output reg 	  S_IN,
		 output reg [15:0] D,
		 output reg [1:0] MODE
		 );
		 
   initial
     begin
	#10 CLK = 1'b0;
	ENB = 1;	
	DIR = 0;
	S_IN = 1;
	// Prueba 5, inicialmente el registro se encuentra
	// indeterminado y se carga 0000 en paralelo
	D[15:0] = 16'b0000000000000000;
	#2 MODE[1:0] = 2'b10;
	// Prueba 1, funcionamiento rotacion izq
	#88 MODE[1:0] = 2'b00;
	// Prueba 2, funcionamiento rotacion der
	#40 DIR = 1;
	S_IN = 0;
	#20 S_IN = 1;
	#2 S_IN = 0;
	#2 S_IN = 1;
	// Prueba 3, rotacion circular a la izq
//	#4 S_IN = 1;
//	#2 MODE[1:0] = 2'b01;
//	DIR = 0;	
	// Prueba 4, rotacion circular a la der	       
//	#6 DIR=1;
	// Demostración de funcionamiento del enable
//	#10 MODE[1:0] = 2'b10;
//	D[7:0] = 8'b11011100;	
//	#4 D[7:0] = 8'b11010011;
//	#2 D[7:0] = 8'b11110110;
//	ENB = 0;
//	#4 D[7:0] = 8'b00010000;
//	#2 D[7:0] = 8'b00011010;
//	#40 ENB = 1;
	



	
     end
   always
     begin
	#1 CLK = ~CLK;
	
     end
   //always 
   //  #25 ENB = ~ENB;
   //always //@ (posedge CLK)
   //  #30 MODE<= (MODE + 2'b01);
   //always //@ (posedge CLK)
   //  #30 D <= (D + 8'b00011100);
		 
endmodule
