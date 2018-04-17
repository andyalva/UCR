//Tclk->Q + Tcombin >= Thold

//delay de 1ns
//granularidad de la simulacion -> 100ps (que tanto puedo partir el tiempo en la simulacion)

`timescale 1ns/100ps
`define NumPwrCntr 4
`define Ndir 2

//*********************NAND Module**********************************************
//5V, 50pF, -40C-125C
module NAND (input A, input B, output C);
	parameter PwrC=0;
  nand #(1:4.5:8.5) (C, A, B);
  
  always @(posedge C)
  	begin
			libreria_tb.memAct.PwrCntr[PwrC] = libreria_tb.memAct.PwrCntr[PwrC] + 1;
		end
endmodule // NAND


//*********************NOR Module***********************************************
//5V, -55C-125C, 50pF
module NOR (input A, input B, output C);
	parameter PwrC=0;
  nor #(3.1:7.6:12.2) (C, A, B);

  always @(posedge C)
  	begin
			libreria_tb.memAct.PwrCntr[PwrC] = libreria_tb.memAct.PwrCntr[PwrC] + 1;
		end
endmodule // NOR


//*********************NOT Module***********************************************
//5V, 50pF
module NOT (input A, output AN);
	parameter PwrC=0;
  not #(1:2.7:4.5) (AN,A);

  always @(posedge AN)
  	begin
			libreria_tb.memAct.PwrCntr[PwrC] = libreria_tb.memAct.PwrCntr[PwrC] + 1;
		end
endmodule // INV


//*********************MUX Module***********************************************
//50pF, 25C, 5V
module MUX (input A, input B, input SEL, output C);
	parameter PwrC=0;
  assign #(0:20:40) C = (SEL) ? A : B;

  always @(posedge C)
  	begin
			libreria_tb.memAct.PwrCntr[PwrC] = libreria_tb.memAct.PwrCntr[PwrC] + 1;
		end
endmodule // MUX


//*********************FFD Module***********************************************
module FFD
(
  input wire CLK,
  input wire iPRE,
  input wire iCLR,
  input wire D,
  output reg Q,
  output reg QN
);

wire PRE, CLR;

not (PRE, iPRE);
not (CLR, iCLR);


//Define times
parameter tw_PRElow_CLRlow=4;
parameter tw_CLKlow_CLKhigh=4;

parameter tsu_DATAlow_DATAhigh=3.5;
parameter tsu_PREinact_CLRinact=1;

parameter th=0;

parameter tlh_PRE_CLK_to_Q_QN_min=1.5;
parameter tlh_PRE_CLK_to_Q_QN_typ=4.2;
parameter tlh_PRE_CLK_to_Q_QN_max=6.6;

parameter thl_PRE_CLK_to_Q_QN_min=1.5;
parameter thl_PRE_CLK_to_Q_QN_typ=4.7;
parameter thl_PRE_CLK_to_Q_QN_max=8.2;

parameter tlh_CLK_to_Q_QN_min=1.5;
parameter tlh_CLK_to_Q_QN_typ=5.4;
parameter tlh_CLK_to_Q_QN_max=7.5;

parameter thl_CLK_to_Q_QN_min=1.5;
parameter thl_CLK_to_Q_QN_typ=5;
parameter thl_CLK_to_Q_QN_max=6.9;


always @ ( CLK or PRE or CLR or D )
begin
  //Preset
  if (~PRE && CLR)
    begin
      Q <= 1;
      QN <= 0;
    end
  //Clear
  else if (PRE && ~CLR)
    begin
      Q <= 0;
      QN <= 1;
    end
  //Prohibited
  else if (~PRE && ~CLR)
    begin
      Q <= 1;
      QN <= 1;
    end
  else if (PRE && CLR)
    begin
      //Hold
      if (~CLK) //negedge, high, low: clk
        begin
          Q <= Q;
          QN <= QN;
        end
      else
        begin
          //Reset
          if (~D)
            begin
              Q <= 0;
              QN <= 1;
            end
          //Set
          else
            begin
              Q <= 1;
              QN <= 0;
            end
        end
    end
  else
    begin
      Q <= Q;
      QN <= QN;
    end
end
endmodule // FFD


//*********************memTrans Module******************************************
module memTrans (dir, LE, dato);
  input [`Ndir:0] dir;
  input LE;
  inout [31:0] dato;
  reg [31:0] PwrCntr [`NumPwrCntr:0];

  //Control de E/S del puerto de datos
  assign dato = (LE)? PwrCntr[dir] : 32'bz;

  //Ciclo de escritura para la memoria
  always @(dir or negedge LE or dato)
    begin
      if (~LE) //escritura
        PwrCntr[dir] = dato;
    end

endmodule //memTrans
