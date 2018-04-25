module LOGICA_SALIDA
  (
   //input
   input wire 	     S_OUT_IN,
   input wire [3:0]  Q_IN,
   input wire 	     CLK,
   //output//
   //register outputs
   output wire 	     S_OUT_OUT,
   output wire [3:0] Q_OUT,
   //ouputs for the action logic
   output wire 	     wS_OUT_N,
   output wire [3:0] wQ_OUT_N
   );

   wire 	     S_OUT_N;
   wire [3:0] 	     Q_OUT_N;

   NOT not0
     (
      .A(S_OUT_N),
      .AN(wS_OUT_N)
      );

   NOT not1
     (
      .A(Q_OUT_N[0]),
      .AN(wQ_OUT_N[0])
      );

   NOT not2
     (
      .A(Q_OUT_N[1]),
      .AN(wQ_OUT_N[1])
      );

   NOT not3
     (
      .A(Q_OUT_N[2]),
      .AN(wQ_OUT_N[2])
      );

   NOT not4
     (
      .A(Q_OUT_N[3]),
      .AN(wQ_OUT_N[3])
      );

   //S_OUT FFD
   FFD #(.PwrC(0)) ffd0
     (
      .CLK(CLK),
      .D(S_OUT_IN),
      .Q(S_OUT_OUT),
      .QN(S_OUT_N)
      );

   //Q[0] FFD
   FFD #(.PwrC(1)) ffd1
     (
      .CLK(CLK),
      .D(Q_IN[0]),
      .Q(Q_OUT[0]),
      .QN(Q_OUT_N[0])
      );

   //Q[1] FFD
   FFD #(.PwrC(2)) ffd2
     (
      .CLK(CLK),
      .D(Q_IN[1]),
      .Q(Q_OUT[1]),
      .QN(Q_OUT_N[1])
      );

   //Q[2] FFD
   FFD #(.PwrC(3)) ffd3
     (
      .CLK(CLK),
      .D(Q_IN[2]),
      .Q(Q_OUT[2]),
      .QN(Q_OUT_N[2])
      );

   //Q[3] FFD
   FFD #(.PwrC(4)) ffd4
     (
      .CLK(CLK),
      .D(Q_IN[3]),
      .Q(Q_OUT[3]),
      .QN(Q_OUT_N[3])
      );

endmodule // LOGICA_SALIDA
