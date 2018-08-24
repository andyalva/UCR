`include "bpbs.v"

module tbbs;

wire clk;
wire [7:0] data, data_in0, data_in1, data_in2, data_in3;

bytestripingRX bytestrip (.clk(clk), .data(data), .reset(reset),.valid(valid),.data_in0(data_in0), .data_in1(data_in1), .data_in2(data_in2), .data_in3(data_in3));
bpbs bancopruebasBS (.clk(clk), .data(data), .reset(reset), .valid(valid),.data_in0(data_in0), .data_in1(data_in1), .data_in2(data_in2), .data_in3(data_in3));

initial begin
    
  //-- Fichero donde almacenar los resultados
  $dumpfile("prueba_Byte_StripingRX.vcd");
  $dumpvars(0, tbbs);
    
  # 600 $display("FIN TestBench");
  $finish;
end


endmodule
