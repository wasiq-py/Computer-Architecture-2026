`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 09:28:02 AM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(
    input clk,
    input MemWrite,
    input [8:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] mem [0:511];
    always @(posedge clk) begin
        if (MemWrite)
            mem[address] <= write_data;
    end
    assign read_data = mem[address];
endmodule