`timescale 1ns/100ps

module probador
(
  //NAND, NOR, INV, MUX
  input wire [2:0] C,
  output reg [3:0] A,
  output reg [2:0] B,

  input wire AN,
  output reg SEL,
  //FFD
  output reg CLK,
  output reg PRE,
  output reg CLR,
  output reg D,
  input wire Q,
  input wire QN,
  //memTrans
	output reg [`Ndir:0] dir,
  output reg LE,
  inout wire [31:0] dato
);

	reg [31:0] Contador;
	assign dato = (~LE)? Contador : 32'bz;

  initial
    begin
      //Borre memoria con contadores de transicion
      #1 LE = 0;
      Contador = 0;
      for (dir=0; dir<=`NumPwrCntr; dir=dir+1)
        #1 Contador = 0;

      repeat (5000)
        begin
        	A[3] <= 0;
        	
          #20 A[0] <= 0;
          B[0] <= 0;

          #20 A[0] <= 1;
          B[0] <= 1;

          #20 A[2] <= 0;
          B[2] <= 0;

          #20 A[2] <= 1;
          B[2] <= 1;
          
          #20 A[3] <= ~A[3];
        end

      //Lea y despliegue la memoria con contadores de transicion
      #100 LE = 1;
      for (dir=0; dir<=`NumPwrCntr; dir=dir+1)
        begin
          #1 Contador = dato;
          $display(,,"PwrCntr[%d]: %d", dir, Contador);
        end
      #1 $finish;
    end

always
  begin
    #5 CLK = ~CLK;
  end
endmodule // probador

