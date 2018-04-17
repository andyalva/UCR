`include "./registro_16b.v"

module Registro_32b ( 
   input wire 	    CLK,
   input wire 	    ENB,
   input wire 	    DIR,
   input wire 	    S_IN,
   input wire [31:0] D,
   input wire [1:0] MODE, 
   output reg 	    S_OUT, 
   output wire [31:0] Q
		  );
   reg 		     r1_in;
   reg		    r0_in;
   wire 	    r1_out;
   wire 	    r0_out; 	    
   reg [1:0] 	    intermode;
 	    
       
   Registro_16b r1(CLK,ENB,DIR,r1_in,D[31:16],intermode,r1_out,Q[31:16]);
   Registro_16b r0(CLK,ENB,DIR,r0_in,D[15:0],intermode,r0_out,Q[15:0]);

   initial
     begin
	S_OUT = 0;
     end
   
   always @(posedge CLK)
     begin	
	if ( MODE == 2'b10)
          begin
	     S_OUT = 0;
	     intermode = 2'b10;	     
	  end
	if ( MODE == 2'b11)
	  begin
	     S_OUT = 0;	     
	     intermode = 2'b11;             
	  end
	if ( MODE == 2'b01)
	  begin
	     S_OUT = 0;       
	     intermode = 2'b00;
	     r1_in = r0_out;
	     r0_in = r1_out;
	  end
	
	
	  if ( MODE == 2'b00)
          begin
	     intermode = 2'b00;
	  end
	 
     end 
   always @*

     begin
	if (intermode == 2'b00)
	  begin
	     if (DIR)
	       begin
		  //r1_in = S_IN;
		  //r0_in = r1_out;
		  S_OUT = r0_out;
	       end
	     else
	       begin
		  //r0_in = S_IN;
		  //r1_in = r0_out;
		  S_OUT = r1_out;		  
	       end // else: !if(DIR)
	  end
     end // always @ *
   always @ *
     begin
	if ( MODE == 2'b01)
	  begin
	     //S_OUT = 0;       
	     //intermode = 2'b00;
	     r1_in = r0_out;
	     r0_in = r1_out;
	  end
	else
	  begin
	     if (DIR)
	       begin
		  r1_in = S_IN;
		  r0_in = r1_out;
		  //S_OUT = r0_out;
	       end
	     else
	       begin
		  r0_in = S_IN;
		  r1_in = r0_out;
		  //S_OUT = r1_out;		  
	       end // else: !if(DIR)
	  end     
     end
endmodule 
