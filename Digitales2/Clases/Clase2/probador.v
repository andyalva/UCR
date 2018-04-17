module testbench(
    input LUZ,
    output reg RST,
    output reg Button);

    reg CLK;
    
    initial begin
        $dumpfile("alarma.vcd");
        $dumpvars;
        $display("\t\t\tCLK,\tRST\tButton\tLUZ");
        $monitor($time,"\t%b\t%b\t\t%b\t\t%b", CLK,RST,Button,LUZ);
        {RST,Button} = 2'b0
         repeat (4) begin
                @(posedge clk);
            {RST,Button} <= {RST,Button} + 1;
        end
        @(posedge CLK)
        {RST,Button} = 'b0;
        $finish
    end

    initial CLK <= 0;
    always #2 CLK <= ~CLK;
endmodule
