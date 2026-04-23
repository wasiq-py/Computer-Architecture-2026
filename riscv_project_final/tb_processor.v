`timescale 1ns / 1ps

module tb_processor();

    // Inputs
    reg clk;
    reg rst;
    reg [15:0] switches;

    // Outputs
    wire [15:0] LEDs;

    // Instantiate the Unit Under Test (UUT)
    project_processor uut (
        .clk(clk), 
        .rst(rst), 
        .switches(switches), 
        .LEDs(LEDs)
    );

    // Generate a simulated 100MHz clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        switches = 16'b0;

        // Apply reset for 20ns to initialize all processor state
        #20;
        rst = 0;

        // Wait a bit to let the processor boot up and enter its polling loop
        #100; 

        // ----------------------------------------------------
        // TEST SCENARIO 1: Test Task A (Switch-controlled Countdown)
        // ----------------------------------------------------
        $display("Testing Task A countdown with switch value 5...");
        switches = 16'h0005; // Input the number 5
        #50;                 // Hold the switch for 5 clock cycles
        switches = 16'h0000; // Turn switches back off

        // Wait for countdown 5->0 to finish. 
        // We give it 5000ns to allow the delay loops to run their course.
        #5000; 
        
        // ----------------------------------------------------
        // TEST SCENARIO 2: Test Task A again with a different number
        // ----------------------------------------------------
        $display("Testing Task A countdown with switch value 3...");
        switches = 16'h0003; // Input the number 3
        #50;                 // Hold the switch for 5 clock cycles
        switches = 16'h0000; // Turn switches back off

        // Wait for countdown 3->0 to finish
        #5000; 

        $display("Simulation Complete.");
        $finish; // End the simulation
    end

endmodule
