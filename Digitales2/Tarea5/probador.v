module probador
  ( 
    output reg 	     CLK,
    output reg 	     ENB,
    output reg 	     DIR,
    output reg 	     S_IN,
    output reg [1:0] MODO,
    output reg [3:0] D
    );


   initial
     begin

        CLK <= 0;
        ENB <= 0;
        S_IN <= 1;
	D <= 4'b0000;
        MODO <= 2'b10;
        DIR <= 0;

	#42 ENB <= 1;

        #10 $display("   Parallel charge");
        #30 D <= 4'b0001;
        #30 D <= 4'b0011;
        #30 D <= 4'b0111;
        #30 D <= 4'b1111;
	
        //Rotation to the left
        #100 $display("    Rotation to the left");
        D <= 4'b0000;
        MODO <= 2'b10;

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

     end

   
   always
     begin
        #20 CLK <= ~CLK;
     end


endmodule // probador
