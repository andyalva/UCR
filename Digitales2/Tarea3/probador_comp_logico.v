`timescale 1ns/100ps
`define NumPwrCntr 4
`define Ndir 2

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

initial
  begin
  	//*********************Prueba NAND**********************************************
  	$display("******************************** NAND");
    A[0] <= 0;
    B[0] <= 0;
    #5 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[0], B[0], C[0]);

    #20 A[0] <= 0;
    B[0] <= 1;
    #5 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[0], B[0], C[0]);

    #20 A[0] <= 1;
     B[0] <= 0;
     #5 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[0], B[0], C[0]);

    #20 A[0] <= 1;
    B[0] <= 1;
		#5 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[0], B[0], C[0]);


		//*********************Prueba NOR***********************************************
    #5 $display("******************************** NOR");
    #20	A[2] <= 0;
    B[2] <= 0;
    #10 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[2], B[2], C[2]);

    #30 A[2] <= 0;
    B[2] <= 1;
    #10 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[2], B[2], C[2]);

    #20 A[2] <= 1;
    B[2] <= 0;
    #10 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[2], B[2], C[2]);

    #20 A[2] <= 1;
    B[2] <= 1;
    #10 $monitor("At time %t, A = %b, B = %b, C = %b ", $time, A[2], B[2], C[2]);
    

		//*********************Prueba NOT***********************************************
    #5 $display("******************************** NOT");
    #20 A[3] <= 0;
    #5 $monitor("At time %t, A = %b, AN = %b", $time, A[3], AN);

    #20 A[3] <= 1;
    #5 $monitor("At time %t, A = %b, AN = %b", $time, A[3], AN);

    #20 A[3] <= 0;
    #5 $monitor("At time %t, A = %b, AN = %b", $time, A[3], AN);

    #20 A[3] <= 1;
    #5 $monitor("At time %t, A = %b, AN = %b", $time, A[3], AN);
    

    //*********************Prueba MUX***********************************************
    #20 $display("******************************** MUX");
    SEL <= 0;
    #20	 A[1] <= 0;
    B[1] <= 0;
    #35 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 0;
    B[1] <= 1;
    #35 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 1;
    B[2] <= 0;
    #35 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 1;
    B[2] <= 1;
    #35 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);


    #50 SEL <= 1;
    #20	 A[1] <= 0;
    B[1] <= 0;
    #30 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 0;
    B[1] <= 1;
    #30 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 1;
    B[2] <= 0;
    #30 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);

    #20 A[1] <= 1;
    B[2] <= 1;
    #30 $monitor("At time %t, SEL = %b, A = %b, B = %b, C = %b ", $time, SEL, A[1], B[1], C[1]);


    //*********************Prueba FFD***********************************************
    #5 $display("******************************** FLIP FLOP D");
    CLK <= 0;
    D <= 0;

    PRE <= 1;
    CLR <= 0;
    #10 $monitor("At time %t, PRE = %b, CLR = %b, D = %b, Q = %b , QN = %b", $time, PRE, CLR, D, Q, QN);
    
    #20 PRE <= 0;
    CLR <= 1;
    #10 $monitor("At time %t, PRE = %b, CLR = %b, D = %b, Q = %b , QN = %b", $time, PRE, CLR, D, Q, QN);

    #20 PRE <= 1;
    CLR <= 1;
    #10 $monitor("At time %t, PRE = %b, CLR = %b, D = %b, Q = %b , QN = %b", $time, PRE, CLR, D, Q, QN);

    #20 PRE <= 0;
    CLR <= 0;
    #10 $monitor("At time %t, PRE = %b, CLR = %b, D = %b, Q = %b , QN = %b", $time, PRE, CLR, D, Q, QN);
    
    #20 D <= 1;
    #10 $monitor("At time %t, PRE = %b, CLR = %b, D = %b, Q = %b , QN = %b", $time, PRE, CLR, D, Q, QN);
  end


initial
  begin
    #10000 $finish;
end

always
  begin
    #5 CLK = ~CLK;
  end
endmodule // probador

