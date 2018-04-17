module reg_interruptor(
input wire CLK,
input wire Button,
input wire RST,
output reg LUZ
);


always @ (posedge CLK)
    begin
        if(RST)
            LUZ = 1'b0;
        else
            if(Button)
                LUZ <= !LUZ;
            else
                LUZ <= LUZ;
    end
endmodule