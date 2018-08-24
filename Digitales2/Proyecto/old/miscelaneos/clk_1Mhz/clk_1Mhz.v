module CLK_1Mhz_cond
    (
        //inputs
        input wire      CLK,
        input wire      RESET,
        //outputs
        output reg      CLK_1Mhz
    );

    reg [1:0]       counter;

    always @(posedge CLK)
        begin
            if (RESET == 1)
                begin
                    counter <= 0;
                    CLK_1Mhz <= 0;
                end
            else
                begin
                    if (counter == 1)
                        begin
                            CLK_1Mhz <= 1;
                        end 
                    else if (counter == 3)
                        begin
                            CLK_1Mhz <= 0;
                            counter <= 0;
                        end
                    counter <= counter + 1;
                end

        end
endmodule