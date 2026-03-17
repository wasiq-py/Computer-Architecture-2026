`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 10:39:17 AM
// Design Name: 
// Module Name: ALUControl_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUControl_tb();
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    
    wire RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    MainControl m1(opcode, RegWrite, ALUOp, MemRead, MemWrite, ALUSrc, MemtoReg, Branch);
    ALUControl a1(ALUOp, funct3, funct7, ALUControl);
    initial begin
        // ADD
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        // SUB
        funct7 = 7'b0100000; #10;
        // AND
        funct3 = 3'b111; funct7 = 7'b0000000; #10;
        // OR
        funct3 = 3'b110; #10;
        // XOR
        funct3 = 3'b100; #10;
        // SLL
        funct3 = 3'b001; #10;
        // SRL
        funct3 = 3'b101; #10;
        // ADDI
        opcode = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        // LOAD
        opcode = 7'b0000011; #10;
        // STORE
        opcode = 7'b0100011; #10;
        // BEQ
        opcode = 7'b1100011; #10;
     end
endmodule
