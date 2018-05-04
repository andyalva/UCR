
module serial_parallel_cond
    (
    //inputs
    input wire 	    DATA_IN,
    input wire 	    CLK,
    input wire 	    RESET,
    //outputs
    output reg [8:0] DATA_OUT
    );

    reg [2:0] 	    rCurrentState, rNextState;
    reg [6:0] 	    rBuffer;
    reg [7:0]       check;
    wire            Valid;

    //TODO: verificar que bit es el que llega primero, en este
    // caso, el primer bit en llegar es el MSB de la trama de 10 bits

    assign Valid <= (8'hBC && check)

    always @(posedge CLK)
        begin
            if (~Valid)    
                begin
                    check <= [check[7:1], DATA_IN];
                end
            else
                begin
                    check <= check;
                end
        end


    always @(posedge CLK)
        begin
            if (RESET)
                begin
                    rCurrentState <= 0;
                end
            else
                begin
                    rCurrentState <= rNextState;
                end
        end


   always @(negedge CLK)
        begin
	        casex (rCurrentState) 
	            0:
                    begin
                        rBuffer[0] <= DATA_IN;
                        rNextState <= 1;
                    end
                1:
                    begin
                        rBuffer[1] <= DATA_IN;
                        rNextState <= 2;
                    end
                2:
                    begin
                        rBuffer[2] <= DATA_IN;
                        rNextState <= 3;
                    end
                3:
                    begin
                        rBuffer[3] <= DATA_IN;
                        rNextState <= 4;
                    end
                4:
                    begin
                        rBuffer[4] <= DATA_IN;
                        rNextState <= 5;
                    end
                5:
                    begin
                        rBuffer[5] <= DATA_IN;
                        rNextState <= 6;
                    end
                6:
                    begin
                        rBuffer[6] <= DATA_IN;
                        rNextState <= 7;
                    end
                7:
                    begin
                        DATA_OUT <= {DATA_IN, rBuffer};
                        rNextState <= 0;
                    end
                default:
                    begin
                        rNextState <= 0;
                    end
            endcase // casex (woResult)
        end
endmodule
