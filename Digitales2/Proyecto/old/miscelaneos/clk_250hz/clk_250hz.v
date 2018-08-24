module CLK_250hz_cond
    (
        //inputs
        input wire      CLK,
        input wire      RESET,
        //outputs
        output reg      CLK_250hz
    );

    reg [4:0]       counter;

    always @(posedge CLK)
        begin
            if (RESET == 1)
                begin
                    counter <= 0;
                    CLK_250hz <= 0;
                end
            else
                begin
                    counter <= counter + 1;
                    if (counter == 7)
                        begin
                            CLK_250hz <= 1;
                        end 
                    else if (counter == 15)
                        begin
                            CLK_250hz <= 0;
                            counter <= 0;
                        end
                end

        end
endmodule