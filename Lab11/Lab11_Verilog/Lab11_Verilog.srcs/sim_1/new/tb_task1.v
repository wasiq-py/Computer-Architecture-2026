`timescale 1ns / 1ps

module tb_Task1;
reg clk, rst;
reg PCSrc;
reg [31:0] instruction;
wire [31:0] PC, PCplus4, branchTarget, nextPC, imm;

pcAdder pa(.PC(PC), .PCplus4(PCplus4));
branchAdder ba(.PC(PC), .imm(imm), .branchTarget(branchTarget));
mux2 m2(.a(PCplus4), .b(branchTarget), .sel(PCSrc), .out(nextPC));
ProgramCounter pc(.clk(clk), .rst(rst), .nextPC(nextPC), .PC(PC));
immGen ig(.instruction(instruction), .imm(imm));

initial clk = 0;
always #5 clk = ~clk;

initial begin
    rst = 1; PCSrc = 0; instruction = 32'd0;
    #12 rst = 0;
    #10;
    #10;
    #10;
    
    instruction = 32'h30000293;
    #1;
    instruction = 32'h00032023;
    #1;
    instruction = 32'hFE058EE3;
    #1;
    PCSrc = 1;
    #10;
    PCSrc = 0;
    #10;
    #10;
    instruction = 32'hFF810113;
    #1;
    instruction = 32'h008000EF;
    #1;
    #20;
    $finish;
end
endmodule