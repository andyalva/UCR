`include "./libreria.v"

module Registro( //estructural
input wire clk,
input wire [3:0] D,
input wire ENB,
input wire Sin,
input wire [1:0] Mode,
input wire DIR,
output reg [3:0] Q,
output reg Sout 
);


//Sout (Sin, Mode)
NOT not1(Sin,a);
NAND nand1(Mode[0], b)
NOT not2(b,c)
NOR nor1(Mode[1],c,Sout)

//Qout (*)





MUX mux0(alpha,beta,DIR,temp0);
MUX mux1(omega, phi, DIR, temp1);
MUX mux2(temp0,temp1,Mode[0],tempdef);
MUX mux3(Q[3:0], D[3:0], Mode[0], sig);
MUX mux4(tempdef, sig, Mode[1], Q[3:0])
