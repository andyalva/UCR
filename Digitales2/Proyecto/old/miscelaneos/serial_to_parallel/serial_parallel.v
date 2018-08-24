
module serial_parallel_cond
    (
    //inputs
    input wire 	    DATA_IN,
    input wire 	    CLK,
    input wire 	    RESET,
    //outputs
    output reg [7:0] DATA_OUT
    );

    reg [2:0] 	    rCurrentState, rNextState;
    reg [6:0] 	    rBuffer;
    reg [7:0]       check;
    reg             Valid;
    reg             Valid_next;
    reg             Valid_neg;
    reg [7:0]       DataOut_next;
    reg             Start;


    always @(*) //HAcer lo mismo con DataOut
        begin
            Valid_next = Valid;
            if (check == 8'hBC)
                begin
                    Valid_next = 1;
                end

        end

    always @(*) //HAcer lo mismo con DataOut
        begin
            DataOut_next = DATA_OUT;
            if (Start == 1)
                begin
                    DataOut_next = 8'hBC;
                end

        end

    always @(*)
        begin
            Valid_neg = ~Valid;
            Start = Valid_neg && Valid_next;
        end    

    always @(posedge CLK)
        begin
            if(RESET)
                begin
                    check <= 0;
                    Valid <= 0;
                    rCurrentState <= 0;
                end
            else
                begin
                    if (Start)
                        begin
                            rCurrentState = 0; 
                        end
                    DATA_OUT <= DataOut_next;
                    Valid <= Valid_next;
                    if (Valid_next == 0)    
                        begin
                            check <= { check[6:0], DATA_IN};
                        end
                    else //Reset = 0 / Valid_next = 1   
                        begin
                            case (rCurrentState) 
                                0:
                                    begin
                                        rBuffer[6] <= DATA_IN;
                                        rCurrentState <= 1;
                                    end
                                1:
                                    begin
                                        rBuffer[5] <= DATA_IN;
                                        rCurrentState <= 2;
                                    end
                                2:
                                    begin
                                        rBuffer[4] <= DATA_IN;
                                        rCurrentState <= 3;
                                    end
                                3:
                                    begin
                                        rBuffer[3] <= DATA_IN;
                                        rCurrentState <= 4;
                                    end
                                4:
                                    begin
                                        rBuffer[2] <= DATA_IN;
                                        rCurrentState <= 5;
                                    end
                                5:
                                    begin
                                        rBuffer[1] <= DATA_IN;
                                        rCurrentState <= 6;
                                    end
                                6:
                                    begin
                                        rBuffer[0] <= DATA_IN;
                                        rCurrentState <= 7;
                                    end
                                7:
                                    begin
                                        DataOut_next <= {rBuffer, DATA_IN};
                                        rCurrentState <= 0;
                                    end
                                default:
                                    begin
                                        rCurrentState <= rCurrentState;
                                    end
                            endcase
                        end
                end 
        end

endmodule
