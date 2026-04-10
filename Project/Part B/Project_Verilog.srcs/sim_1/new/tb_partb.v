`timescale 1ns / 1ps

module tb_task2;

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
        
        #20000;
        $finish;
    end

    // Monitor LEDs for changes
    always @(LEDs) begin
        $display("Time=%0t | LEDs=%h (decimal %0d) | PC=%0d", $time, LEDs, LEDs, uut.PC);
    end

endmodule
