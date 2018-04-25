
module Registro8( //estructural
input wire clk,
input wire [3:0] D,
input wire ENB,
input wire Sin,
input wire [1:0] Mode,
output reg [3:0] Q,
output reg Sout 
);

    Registro r1(CLK,ENB,DIR,r1_in,D[7:4],intermode,r1_out,Q[7:4]);
    Registro r0(CLK,ENB,DIR,r0_in,D[3:0],intermode,r0_out,Q[3:0]);
