module LOGICA_DESICION 
  (
   //input
   input wire 	    DIR,
   input wire [1:0] MODO,
   input wire 	    ENB, 
   //output
   output reg [5:0] Signal  
   );

   wire [5:0] 	    wSignalOut;

   //****SET Signal[0]****
   wire  	    wSignal0;   
   
   NAND nand0
     (
      .A(ENB),
      .B(wSignal0),
      .C(wSignalOut[0])
      );

   NAND nand1
     (
      .A(MODO[1]),
      .B(MODO[0]),
      .C(wSignal0)
      );

   //****SET Signal[1]****   
   wire [3:0] 	    wSignal1;
   
   NAND nand2
     (
      .A(ENB),
      .B(wSignal1[1]),
      .C(wSignal1[0])
      );

   NOR nor0
     (
      .A(wSignal1[0]),
      .B(wSignal1[2]),
      .C(wSignalOut[1])
      );

   NOR nor5
     (
      .A(MODO[0]),
      .B(DIR),
      .C(wSignal1[3])
      );
   
   NOT not0
     (
      .A(MODO[1]),
      .AN(wSignal1[1])
      );

   NOT not1
     (
      .A(wSignal1[3]),
      .AN(wSignal1[2])
      );

   //****SET Signal[2]****   
   wire [3:0] 	    wSignal2;

   NAND nand8
     (
      .A(ENB),
      .B(wSignal2[0]),
      .C(wSignal2[1])
      );

   NOR nor1
     (
      .A(wSignal2[1]),
      .B(wSignal2[3]),
      .C(wSignalOut[2])
      );
   
   NOT not2
     (
      .A(MODO[1]),
      .AN(wSignal2[0])
      );

   NOT not3
     (
      .A(MODO[0]),
      .AN(wSignal2[2])
      );

   NAND nand3
     (
      .A(wSignal2[2]),
      .B(DIR),
      .C(wSignal2[3])
      );

   //****SET Signal[3]****   
   wire [3:0] 	    wSignal3;

   NAND nand9
     (
      .A(ENB),
      .B(wSignal3[0]),
      .C(wSignal3[1])
      );

   NAND nand4
     (
      .A(MODO[0]),
      .B(wSignal3[3]),
      .C(wSignal3[2])
      );
   
   NOR nor2
     (
      .A(wSignal3[1]),
      .B(wSignal3[2]),
      .C(wSignalOut[3])
      );

   NOT not4
     (
      .A(MODO[1]),
      .AN(wSignal3[0])
      );

   NOT not5
     (
      .A(DIR),
      .AN(wSignal3[3])
      );

   //****SET Signal[4]****
   wire [2:0] 	    wSignal4;

   NAND nand5
     (
      .A(ENB),
      .B(wSignal4[0]),
      .C(wSignal4[1])
      );

   NAND nand6
     (
      .A(MODO[0]),
      .B(DIR),
      .C(wSignal4[2])
      );
   
   NOR nor3
     (
      .A(wSignal4[1]),
      .B(wSignal4[2]),
      .C(wSignalOut[4])
      );

   NOT not6
     (
      .A(MODO[1]),
      .AN(wSignal4[0])
      );

   //****SET Signal[5]****
   wire 	    wSignal5;

   NAND nand7
     (
      .A(ENB),
      .B(MODO[1]),
      .C(wSignal5)
      );
   
   NOR nor4
     (
      .A(wSignal5),
      .B(MODO[0]),
      .C(wSignalOut[5])
      );

   
   always @ (*)
     begin
	Signal <= wSignalOut;
     end   

endmodule // LOGICA_DESICION
