
module tester
    (
    output reg [1:0] Signal,
    output reg 	    CLK,
    output reg 	    RESET
    );

    initial
        begin
            CLK = 1;
            RESET = 0;
            #3 RESET = 1;
            #15 RESET = 0;
        end
    always @(posedge CLK)
        begin
            #2 Signal <= 0;
            #2 Signal <= 0;
            #2 Signal <= 1;
            #2 Signal <= 2;
            #2 Signal <= 2;
            #2 Signal <= 2;
            #2 Signal <= 0;
            #2 Signal <= 1;
            #2 Signal <= 1;
            #2 Signal <= 0;
        end

    always
        begin
            #1 CLK = ~CLK;
        end

    endmodule
