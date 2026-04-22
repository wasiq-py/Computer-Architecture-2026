// ============================================
// Lab 11 - Task 2: Testbench for Top Level Processor
// Simulates the processor running the FSM program
// ============================================
`timescale 1ns/1ps

module tb_processor_top();

    reg clk;
    reg rst;
    reg [15:0] switches;
    wire [15:0] LEDs;

    // Instantiate the top-level processor
    processor_top uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .LEDs(LEDs)
    );

    // Clock generation (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor LED changes
    initial begin
        $monitor("Time: %0t | Switches: %d | LEDs: %d", $time, switches, LEDs);
    end

    // Test sequence
    initial begin
        // Initialize inputs
        switches = 16'd5; // Set switch input to 5
        rst = 1;          // Assert reset

        // Hold reset for a few cycles
        #20;
        rst = 0;          // De-assert reset

        // Let the FSM run. It reads switches, then counts down on LEDs
        // Each loop iteration takes several cycles, delay loop adds more
        #10000;
        
        $display("Simulation finished.");
        $finish;
    end

    // Dump waves for viewing in GTKWave
    initial begin
        $dumpfile("tb_processor_top.vcd");
        $dumpvars(0, tb_processor_top);
    end

endmodule
