`timescale 1ns/100ps
`define NumPwrCntr 4
`define Ndir 2

//*********************NAND Module**********************************************
module NAND (input A, input B, output C);
   nand #(1:4.5:8.5) (C, A, B);
endmodule // NAND


//*********************NOR Module***********************************************
module NOR (input A, input B, output C);
   nor #(3.1:7.6:12.2) (C, A, B);
endmodule // NOR


//*********************NOT Module***********************************************
module NOT (input A, output AN);
   not #(1:2.7:4.5) (AN,A);
endmodule // INV


//*********************MUX Module***********************************************
module MUX (input IN_A, input IN_B, input SEL, output OUT_C);
   assign #(0.5:3:5) OUT_C = (SEL) ? IN_B : IN_A;
endmodule // MUX


//*********************FFD Module***********************************************
module FFD
  (
   input wire CLK,
   input wire D,
   output reg Q,
   output reg QN
   );

   parameter PwrC=0;

   always @ ( posedge CLK )
     begin
	Q <= D;
	QN <= ~D;
	Testbech.memAct.PwrCntr[PwrC] = Testbech.memAct.PwrCntr[PwrC] + 1;
     end

   //Manejo de tiempos Setup y Hold
   always @(posedge CLK)

     begin
        #1
          if (D == 1) begin
             #3.5 if (D != 1) begin
                $monitor(" Fallo en tiempo de setup en alto %g\t",$time);
                #1 if (D != D)
                  $monitor("Fallo en tiempo de hold en alto %g\t",$time);
             end
          end

        if (D == 0) begin
           #3.5 if (D != 0) begin
              $monitor("Fallo en tiempo de setup en bajo %g\t",$time);
              #1 if (D != D)
                $monitor("Fallo en tiempo de hold en bajo %g\t",$time);
           end
        end
     end

endmodule // FFD


//*********************memTrans Module******************************************
module memTrans (dir, LE, dato);
   input [`Ndir:0] dir;
   input 	   LE;
   inout [31:0]    dato;
   reg [31:0] 	   PwrCntr [`NumPwrCntr:0];

   assign dato = (LE)? PwrCntr[dir] : 32'bz;

   always @(dir or negedge LE or dato)
     begin
	if (~LE) //escritura
          PwrCntr[dir] = dato;
     end

endmodule //memTrans
