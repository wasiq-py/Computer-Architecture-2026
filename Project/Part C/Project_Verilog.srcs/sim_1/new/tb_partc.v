`timescale 1ns / 1ps

module tb_task3;

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

        // Fibonacci runs automatically, no switch input needed
        // Expected LEDs: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, then 0 (halt)
        #30000;
        $finish;
    end

    // Monitor LED changes only
    always @(LEDs) begin
        $display("Time=%0t | LEDs=%0d (hex=%h)", $time, LEDs, LEDs);
    end

endmodule
