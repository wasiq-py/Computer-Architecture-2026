`timescale 1ns / 1ps

module tb_TopLevelProcessor;

    reg clk;
    reg rst;
    reg [15:0] switches;
    wire [15:0] LEDs;

    TopLevelProcessor uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .LEDs(LEDs)
    );

    always #50 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        switches = 16'd0;
        #200;
        rst = 0;
        #2000;
        switches = 16'd3;
        #10000;
        switches = 16'd0;
        #2000;
        switches = 16'd5;
        #15000;
        switches = 16'd0;
        #2000;
    end
    initial begin
        $monitor("Time=%0t | PC=%0d | Inst=%h | LEDs=%0d | switches=%0d | rst=%b",
                 $time, uut.PC, uut.instruction, LEDs, switches, rst);
    end

endmodule
