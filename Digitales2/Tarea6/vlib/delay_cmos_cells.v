module BUF(A, Y);
   input A;
   output Y;
   assign Y = A;
endmodule // BUF

//----------------------------------------

module NOT(A, Y);
   input A;
   output Y;
   assign  #2.7 Y = ~A;
endmodule // NOT

//----------------------------------------

module NAND(A, B, Y);
   input A, B;
   output Y;
   assign #4.5 Y = ~(A & B);
endmodule // NAND

//----------------------------------------

module NOR(A, B, Y);
   input A, B;
   output Y;
   assign  #7.6 Y = ~(A | B);
endmodule // NOR

//----------------------------------------

module DFF(C, D, Q);
   input C, D;
   output reg Q;
   always @(posedge C)
     Q <= D;
endmodule // DFF

//----------------------------------------

module DFFSR(C, D, Q, S, R);
   input C, D, S, R;
   output reg Q;
   always @(posedge C, posedge S, posedge R)
     if (S)
       Q <= 1'b1;
     else if (R)
       Q <= 1'b0;
     else
       Q <= D;
endmodule // DFFSR

//----------------------------------------