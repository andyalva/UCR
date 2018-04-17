module libreria_tb ();

//Wire needed
wire [3:0] A;
wire AN;
wire [2:0] B;
wire [2:0] C;
wire SEL;
wire CLK;
wire PRE;
wire CLR;
wire D;
wire Q;
wire QN;
wire [`Ndir:0] dir;
wire LE;
wire [31:0] dato;

probador prob (
    .A(A),
    .AN(AN),
    .B(B),
    .C(C),
    .SEL(SEL),
    .CLK(CLK),
    .PRE(PRE),
    .CLR(CLR),
    .D(D),
    .Q(Q),
    .QN(QN),
    .dir(dir),
    .LE(LE),
    .dato(dato)
  );

NAND nnand (
		.A(A[0]),
		.B(B[0]),
		.C(C[0])
	);

MUX mmux (
    .A(A[1]),
    .B(B[1]),
    .C(C[1]),
    .SEL(SEL)
  );

NOR nnor (
    .A(A[2]),
    .B(B[2]),
    .C(C[2])
  );

NOT nnot(
    .A(A[3]),
    .AN(AN)
  );
  
FFD fffd (
    .CLK(CLK),
    .iPRE(PRE),
    .iCLR(CLR),
    .D(D),
    .Q(Q),
    .QN(QN)
  );

memTrans memAct (
		.dir(dir),
		.LE(LE),
		.dato(dato)
	);

initial
  begin
    $dumpfile("libreria.vcd");
    $dumpvars();
end

endmodule // libreria_tb
