`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 10:02:24 AM
// Design Name: 
// Module Name: MainControl
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


module MainControl(
    input [6:0] opcode,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output reg MemRead, MemWrite, ALUSrc, MemtoReg, Branch
    );
    always@(*) begin
    RegWrite = 1'b0;
    ALUOp = 2'b00;
    MemRead = 1'b0;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    MemtoReg = 1'b0;
    Branch = 1'b0;

    case (opcode)
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUOp = 2'b10;
        end

        7'b0010011: begin
            RegWrite = 1'b1;
            ALUOp = 2'b10;
            ALUSrc = 1'b1;
        end

        7'b0000011: begin
            RegWrite = 1'b1;
            ALUOp = 2'b00;
            MemRead = 1'b1;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
        end

        7'b0100011: begin
            ALUOp = 2'b00;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
        end

        7'b1100011: begin
            ALUOp = 2'b01;
            Branch = 1'b1;
        end
    endcase
    end
endmodule
