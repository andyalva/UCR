module LOGICA_ACCION
  (
   //inputs
   input wire [3:0] Q_IN,
   input wire 	    S_IN,
   input wire [5:0] SEL,
   input wire [3:0] D,
   input wire 	    S_OUT_IN,
   //outputs
   output reg [3:0] Q_OUT,
   output reg 	    S_OUT
   );

   wire [4:0] wResult;
   wire [26:0] 	    wMux;
   assign wMux[0] = 0;
   assign wMux[6] = 0;
   assign wMux[12] = 0;
   assign wMux[18] = 0;
   assign wMux[24] = 0;


always @(*)
begin
	Q_OUT <= wResult[3:0];
	S_OUT <= wResult[4];
end



 //*****************OUT: Q[0]**********
 MUX t_mux0 (
    .IN_A(wMux[0]),
    .IN_B(Q_IN[0]),
    .OUT_C(wMux[1]),
    .SEL(SEL[0])
  );

MUX t_mux1 (
    .IN_A(wMux[1]),
    .IN_B(S_IN),
    .OUT_C(wMux[2]),
    .SEL(SEL[1])
  );

MUX #10 t_mux2 (
    .IN_A(wMux[2]),
    .IN_B(Q_IN[1]),
    .OUT_C(wMux[3]),
    .SEL(SEL[2])
  );

MUX t_mux3 (
    .IN_A(wMux[3]),
    .IN_B(Q_IN[3]),
    .OUT_C(wMux[4]),
    .SEL(SEL[3])
  );

MUX t_mux4 (
    .IN_A(wMux[4]),
    .IN_B(Q_IN[1]),
    .OUT_C(wMux[5]),
    .SEL(SEL[4])
  );

MUX t_mux5 (
    .IN_A(wMux[5]),
    .IN_B(D[0]),
    .OUT_C(wResult[0]),
    .SEL(SEL[5])
  );

//**************OUT: Q[1]*********************

 MUX t_mux6 (
    .IN_A(wMux[6]),
    .IN_B(Q_IN[1]),
    .OUT_C(wMux[7]),
    .SEL(SEL[0])
  );

 MUX t_mux7 (
    .IN_A(wMux[7]),
    .IN_B(Q_IN[0]),
    .OUT_C(wMux[8]),
    .SEL(SEL[1])
  );

 MUX t_mux8 (
    .IN_A(wMux[8]),
    .IN_B(Q_IN[2]),
    .OUT_C(wMux[9]),
    .SEL(SEL[2])
  );

 MUX t_mux9 (
    .IN_A(wMux[9]),
    .IN_B(Q_IN[0]),
    .OUT_C(wMux[10]),
    .SEL(SEL[3])
  );

 MUX t_mux10 (
    .IN_A(wMux[10]),
    .IN_B(Q_IN[2]),
    .OUT_C(wMux[11]),
    .SEL(SEL[4])
  );

 MUX t_mux11 (
    .IN_A(wMux[11]),
    .IN_B(D[1]),
    .OUT_C(wResult[1]),
    .SEL(SEL[5])
  );


//**************OUT: Q[2]*********************

 MUX t_mux12 (
    .IN_A(wMux[12]),
    .IN_B(Q_IN[2]),
    .OUT_C(wMux[13]),
    .SEL(SEL[0])
  );

 MUX t_mux13 (
    .IN_A(wMux[13]),
    .IN_B(Q_IN[1]),
    .OUT_C(wMux[14]),
    .SEL(SEL[1])
  );

 MUX t_mux14 (
    .IN_A(wMux[14]),
    .IN_B(Q_IN[3]),
    .OUT_C(wMux[15]),
    .SEL(SEL[2])
  );

 MUX t_mux15 (
    .IN_A(wMux[15]),
    .IN_B(Q_IN[1]),
    .OUT_C(wMux[16]),
    .SEL(SEL[3])
  );

 MUX t_mux16 (
    .IN_A(wMux[16]),
    .IN_B(Q_IN[3]),
    .OUT_C(wMux[17]),
    .SEL(SEL[4])
  );

 MUX t_mux17 (
    .IN_A(wMux[17]),
    .IN_B(D[2]),
    .OUT_C(wResult[2]),
    .SEL(SEL[5])
  );


//**************OUT: Q[3]*********************

 MUX t_mux18 (
    .IN_A(wMux[18]),
    .IN_B(Q_IN[3]),
    .OUT_C(wMux[19]),
    .SEL(SEL[0])
  );

 MUX t_mux19 (
    .IN_A(wMux[19]),
    .IN_B(Q_IN[2]),
    .OUT_C(wMux[20]),
    .SEL(SEL[1])
  );

 MUX t_mux20 (
    .IN_A(wMux[20]),
    .IN_B(S_IN),
    .OUT_C(wMux[21]),
    .SEL(SEL[2])
  );

 MUX t_mux21 (
    .IN_A(wMux[21]),
    .IN_B(Q_IN[2]),
    .OUT_C(wMux[22]),
    .SEL(SEL[3])
  );

 MUX t_mux22 (
    .IN_A(wMux[22]),
    .IN_B(Q_IN[0]),
    .OUT_C(wMux[23]),
    .SEL(SEL[4])
  );

 MUX t_mux23 (
    .IN_A(wMux[23]),
    .IN_B(D[3]),
    .OUT_C(wResult[3]),
    .SEL(SEL[5])
  );


//**************OUT: S_OUT*********************

 MUX t_mux24 (
    .IN_A(wMux[24]),
    .IN_B(S_OUT_IN),
    .OUT_C(wMux[25]),
    .SEL(SEL[0])
  );

 MUX t_mux25 (
    .IN_A(wMux[25]),
    .IN_B(Q_IN[3]),
    .OUT_C(wMux[26]),
    .SEL(SEL[1])
  );

 MUX t_mux26 (
    .IN_A(wMux[26]),
    .IN_B(Q_IN[0]),
    .OUT_C(wResult[4]),
    .SEL(SEL[2])
  );

endmodule // LOGICA_ACCION
