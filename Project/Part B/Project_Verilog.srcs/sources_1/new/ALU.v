`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2026 10:53:40 AM
// Design Name: 
// Module Name: ALU
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


module ALU(input [31:0] A, input [31:0] B, input [3:0] ALUControl, output reg [31:0] ALUResult, output Zero);
always @(*) 
    begin
        case(ALUControl)
            4'b0000: ALUResult = A + B;
            4'b0001: ALUResult = A - B;
            4'b0010: ALUResult = A & B;
            4'b0011: ALUResult = A | B;
            4'b0100: ALUResult = A ^ B;
            4'b0101: ALUResult = A << B[4:0];
            4'b0110: ALUResult = A >> B[4:0];
            4'b0111: ALUResult = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
            default: ALUResult = 32'b0;
        endcase
    end
assign Zero = (ALUResult == 0);
endmodule