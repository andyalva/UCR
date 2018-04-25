module reg_e # (parameter SIZE=4)
   (
    //INPUT
    input wire 		   CLK,
    input wire 		   ENB,
    input wire 		   DIR,
    input wire 		   S_IN,
    input wire [1:0] 	   MODO,
    input wire [SIZE-1:0]  D,
    //OUTPUT
    output wire [SIZE-1:0] Q,
    output wire 	   S_OUT
    );


   wire [5:0] 		   wSignal;
   wire [3:0] 		   wData;
   wire 		   wS_OUT_LA;
   wire 		   wS_OUT_IN_LA;
   wire [3:0] 		   wQ_OUT_IN;
   wire 		   wS_OUT_N;
   

   LOGICA_DESICION log_des
     (
      .DIR(DIR),
      .MODO(MODO),
      .ENB(ENB),
      .Signal(wSignal)
      );

   LOGICA_ACCION log_acc
     (
      .Q_IN(wQ_OUT_IN),
      .S_IN(S_IN),
      .SEL(wSignal),
      .D(D),
      .S_OUT_IN(wS_OUT_N),
      .Q_OUT(wData),
      .S_OUT(wS_OUT_LA)
      );

   LOGICA_SALIDA log_sal
     (
      .S_OUT_IN(wS_OUT_LA),
      .Q_IN(wData),
      .S_OUT_OUT(S_OUT),
      .Q_OUT(Q),
      .wS_OUT_N(wS_OUT_N),
      .wQ_OUT_N(wQ_OUT_IN),
      .CLK(CLK)
      );

endmodule //reg
