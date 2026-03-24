`timescale 1ns / 1ps

module tb_TopLevelProcessor;
reg clk, rst;
reg [15:0] switches;
wire [15:0] LEDs;

TopLevelProcessor tlp(.clk(clk), .rst(rst), .switches(switches), .LEDs(LEDs));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    rst = 1;
    switches = 16'd5;
    #20;
    rst = 0;
    #2000;
end
endmodule
