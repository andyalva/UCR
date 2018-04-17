module Probador (
		 output reg 	  CLK,
		 output reg 	  ENB,
		 output reg 	  DIR,
		 output reg 	  S_IN,
		 output reg [31:0] D,
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
	D[31:0] = 32'd4294967293;
	// Demostración de funcionamiento del enable
	#10 MODE[1:0] = 2'b10;
	D[31:0] = 32'd293;	
	#4 D[31:0] = 32'd427293;
	#2 D[31:0] = 32'd42949;
	ENB = 0;
	#4 D[31:0] = 32'd4297293;
	#2 D[31:0] = 32'd967293;
	#40 ENB = 1;
	#100 MODE[1:0] = 2'b01;
	#60 MODE[1:0] = 2'b00;
	S_IN = 0;	
	#40 DIR = ~DIR;
	#40 MODE[1:0] = 2'b10;
	#50 MODE[1:0] = 2'b01;
	#50 DIR = ~DIR;
	
	
     end
   always
     begin
	#1 CLK = ~CLK;
	
     end
   //always 
   //  #25 ENB = ~ENB;
   //always //@ (posedge CLK)
   //  #30 MODE<= (MODE + 2'b01);
   always //@ (posedge CLK)
     #30 D <= (D + 32'd29293);
		 
endmodule
