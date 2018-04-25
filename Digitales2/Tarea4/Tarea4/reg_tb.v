module Testbech();

   //Defined to connect SSR4b and Tester modules.
   wire CLK, ENB, DIR, S_IN, SOUT, SOUT_C, SOUT_E;
   wire [1:0] MODO;
   wire [3:0] D, Q_C, Q_E;
   //Defined to connecto memTrans and Tester modules.
   wire [`Ndir:0] dir;
   wire 	  LE;
   wire [31:0] 	  dato;

   //Instantiate estructural 4b Synchronous Scrollable Register.
   reg_e reg_estructural
     (
      //module inputs.
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_IN),
      .MODO(MODO),
      .D(D),

      //module outputs.
      .Q(Q_E),
      .S_OUT(S_OUT_E)
      );

   //Instantiate  structural 4b Synchronous Scrollable Register.
   reg_c reg_conductual
     (
      //module inputs.
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_IN),
      .MODO(MODO),

      //module outputs.
      .Q(Q_C),
      .S_OUT(S_OUT_C),
      .D(D)
      );

   //Instantiate Tester module.
   Tester tester
     (
      //module inputs.
      .S_OUT_C(S_OUT_C),
      .S_OUT_E(S_OUT_E),
      .Q_C(Q_C),
      .Q_E(Q_E),

      //module outputs.
      .CLK(CLK),
      .ENB(ENB),
      .DIR(DIR),
      .S_IN(S_IN),
      .MODO(MODO),
      .D(D),
      .dir(dir),
      .LE(LE),
      .dato(dato)
      );

   memTrans memAct 
     (
      .dir(dir),
      .LE(LE),
      .dato(dato)
      );
   
   initial
     begin
        //For GTKWave usage.
        $dumpfile("registro.vcd");
        $dumpvars();
     end
endmodule // Testbech
