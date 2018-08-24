`include "bpfsm.v"

module tbbs;

wire clk;
wire [3:0] data_Fifo, error_full, pausa, continua;

FSM maqest (.clk(clk), .data_Fifo(data_Fifo), .reset(reset), .init(init), .almost_full(almost_full), .almost_empty(almost_empty), .empty_Fifo(empty_Fifo), .no_empty_Fifo(no_empty_Fifo), .Fifo_overflow(Fifo_overflow),.error_full(error_full), .pausa(pausa), .continua(continua));
bpfsm bancopruebasFSM (.clk(clk), .data_Fifo(data_Fifo), .reset(reset), .init(init), .almost_full(almost_full), .almost_empty(almost_empty), .empty_Fifo(empty_Fifo), .no_empty_Fifo(no_empty_Fifo), .Fifo_overflow(Fifo_overflow),.error_full(error_full), .pausa(pausa), .continua(continua));

initial begin
    
  //-- Fichero donde almacenar los resultados
  $dumpfile("prueba_FSM.vcd");
  $dumpvars(0, tbbs);
    
  # 600 $display("FIN TestBench");
  $finish;
end


endmodule
