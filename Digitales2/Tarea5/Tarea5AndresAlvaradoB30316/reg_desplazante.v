module reg_desplazante # (parameter SIZE=4)
( input wire CLK,
  input wire ENB,
  input wire DIR,
  input wire S_IN,
  input wire [1:0] MODO,
  input wire [SIZE-1:0] D,
  output reg [SIZE-1:0] Q,
  output reg S_OUT
);

always @ (posedge CLK)
  begin
    if (ENB)
      begin
        case (MODO)
          //*********************Rotation***************************************
          2'b00 : if (~DIR) //left
                    begin
                      S_OUT <= Q[3];
                      Q <= {Q[2:0], S_IN};
                    end
                  else //right
                    begin
                      S_OUT <= Q[0];
                      Q <= {S_IN, Q[3:1]};
                    end
          //*********************Circular rotation******************************
          2'b01 : if (~DIR) //left
                    begin
                      Q[3:0] <= {Q[2:0], Q[3]};
                      S_OUT <= 0;
                    end
                  else //right
                    begin
                      Q[3:0] <= {Q[0], Q[3:1]};
                      S_OUT <= 0;
                    end
          //*********************Parallel charge********************************
          2'b10 : begin
                    Q <= D;
                    S_OUT <= 0;
                  end
          //*********************Default****************************************
          default:
            begin
              Q <= Q;
              S_OUT <= S_OUT;
            end
        endcase
      end
    else
      begin
        Q <= Q;
        S_OUT <= S_OUT;
      end
  end


endmodule //reg_desplazante
