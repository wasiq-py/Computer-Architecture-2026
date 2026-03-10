`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 10:46:06 AM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input pbin,
    output reg pbout
);
    reg [19:0] cnt = 0;
    reg sync = 0;
    always @(posedge clk) begin
        sync <= pbin;
        if (sync != pbout) begin
            cnt <= cnt + 1;
            if (cnt == 20'hFFFFF) begin
                pbout <= sync;
                cnt <= 0;
            end
        end else begin
            cnt <= 0;
        end
    end
endmodule

