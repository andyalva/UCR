module  upcounter #(parameter WIDTH=8)
   (
    input wire 		   reset,
    input wire 		   enable,
    input wire 		   clock,
    output reg [WIDTH-1:0] oResult
    );

   always @(posedge clock)
     begin
	if (reset)
	  begin
	     oResult <= 0;
	  end
	else
	  begin
	     if (enable)
	       begin
		  oResult <= oResult + 1;
	       end
	     else
	       begin
		  oResult <= oResult;
	       end
	  end
     end

endmodule
