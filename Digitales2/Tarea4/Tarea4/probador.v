module Tester
  (
   //module outputs.
   output reg 		CLK,
   output reg 		ENB,
   output reg 		DIR,
   output reg 		S_IN,
   output reg [1:0] 	MODO,
   output reg [3:0] 	D,
   output reg 		LE,
   output reg [`Ndir:0] dir,

   //module inputs
   input wire 		S_OUT_E,
   input wire 		S_OUT_C,
   input wire [3:0] 	Q_C, Q_E,
   input wire 		test,
   inout wire [31:0] 	dato
   );


   reg [31:0] 		Contador;
   assign dato = (~LE)? Contador : 32'bz;



   initial
     begin

        CLK <= 0;
        ENB <= 0;
        S_IN <= 1;
	D <= 4'b0000;
        MODO <= 2'b10;
        DIR <= 0;

        //**********Instrumentation code
        //Clear memory
        #1 LE = 0;
        Contador = 0;
        for (dir=0; dir<=`NumPwrCntr; dir=dir+1)
          begin
             #1 Contador = 0;
          end


        //**********Temporal and conductual tests*************
	#7 ENB <= 1;
	
        #10 $display("   Parallel charge");
        D <= 4'b0000;
        MODO <= 2'b10;
        #30 D <= 4'b0001;
        #30 D <= 4'b0011;
        #30 D <= 4'b0111;
        #30 D <= 4'b1111;
	
        //Rotation to the left
        # 100 $display("    Rotation to the left");
        D <= 4'b0000;
        MODO <= 2'b10;

/* -----\/----- EXCLUDED -----\/-----
        #7 ENB <= 1;
 -----/\----- EXCLUDED -----/\----- */

        #100 MODO <= 2'b00;

        //Rotation to the right
        #200 $display("   Rotation to the right");
        DIR <= 1;
        S_IN <= 0;

        //Circular rotation to the left
        #200 $display("   Circular rotation to the left");
        MODO <= 2'b10;
        D <= 4'b0111;

        #200 MODO <= 2'b01;
        DIR <= 0;

        //Circular rotation to the right
        #200 $display("   Circular rotation to the right");
        DIR <= 1;


        //**********Instrumentation code
        //Reas and write the memory
        #200 LE = 1;

	$display("   Print PwrCntr");
        for (dir=0; dir<=`NumPwrCntr; dir=dir+1)
          begin
             #1 Contador = dato;
             $display(,,"PwrCntr[%d]: %d", dir, Contador);
          end

        #1 $finish;
     end

   
   always
     begin
        #20 CLK <= ~CLK;
     end

   
   always @ (*)
     begin
        if (S_OUT_C != S_OUT_E)
          begin
             $monitor("Salida S_OUT distinta entre los registros.");
          end

        else if (Q_C[3:0] != Q_E[3:0])
          begin
             $monitor ("Salida Q distinta entre los registros.");
          end
     end

   
   always @ ( posedge CLK )
     begin
        $monitor("At time %t, Q_E = %4b, S_OUT_E = %b ", $time, Q_E, S_OUT_E);
     end

endmodule
