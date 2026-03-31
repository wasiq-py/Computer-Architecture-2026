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

        // Program runs automatically - no switch input needed
        // Test 1: SLT(5,10) → LEDs = 0x0001
        // Test 1b: SLT(10,5) → LEDs = 0x0000
        // Test 2: BGE(10,5) skips → LEDs = 0x00AA
        // Test 3: LUI 0xABCDE → LEDs = 0xE000
        // Then halts in infinite loop

        #20000;
        $finish;
    end

    // Monitor LEDs for changes
    always @(LEDs) begin
        $display("Time=%0t | LEDs=%h (decimal %0d) | PC=%0d", $time, LEDs, LEDs, uut.PC);
    end

endmodule
