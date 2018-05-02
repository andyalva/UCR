module Registro ( 
   input wire 	    CLK,
   input wire 	    ENB,
   input wire 	    DIR,
   input wire 	    S_IN,
   input wire [3:0] D,
   input wire [1:0] MODE, 
   output reg 	    S_OUT, 
   output reg [3:0] Q
		  );
   initial
     begin
	S_OUT = 0;
     end
   
   always @(posedge CLK)
     begin
	if (ENB)
	  begin
	     
	     if ( MODE == 2'b10)
               begin
		  S_OUT = 0;	     
		  Q[3:0] <= D[3:0];
	       end
	     if ( MODE == 2'b11)
               S_OUT = 0;
	     
	     if ( MODE == 2'b01)
	       begin
		  S_OUT = 0;       
		  if (DIR)
		    Q[3:0] = {Q[0],Q[3:1]};
		  else
		    Q[3:0] = {Q[2:0],Q[3]};
	       end
	     
	     if ( MODE == 2'b00)
               begin
		  if (DIR)
		    begin
		       //S_OUT = Q[0];
		       Q[3:0] = {S_IN,Q[3:1]};
		    end
		  else
		    begin
		       //S_OUT = Q[3];
		       Q[3:0] = {Q[2:0],S_IN};
		    end
	       end
	     
	  end     
     end // always @ (posedge CLK)
   always @ (negedge CLK)
     begin
	if ( MODE == 2'b00)
          begin
	     if (DIR)
	       begin
		  S_OUT <= Q[0];
		  //Q[3:0] = {S_IN,Q[3:1]};
	       end
	     else
	       begin
		  S_OUT <= Q[3];
		  //Q[3:0] = {Q[2:0],S_IN};
	       end
	  end
     end
   
endmodule 
