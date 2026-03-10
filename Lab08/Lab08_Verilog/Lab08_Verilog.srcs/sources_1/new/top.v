`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2026 10:40:01 AM
// Design Name: 
// Module Name: top
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

module top(input wire clk, input wire rst, input wire [15:0] switches, output wire [15:0] leds);
    wire rst_clean;
    reg [2:0] state;
    reg [31:0] address;
    reg readEnable, writeEnable;
    reg [31:0] writeData;
    wire [31:0] readData;

    debouncer db(.clk(clk), .pbin(rst), .pbout(rst_clean));
    addressDecoderTop adt(.clk(clk), .rst(rst_clean), .address(address), .readEnable(readEnable), .writeEnable(writeEnable), .writeData(writeData), .switches(switches), .readData(readData), .leds(leds));

    always @(posedge clk or posedge rst_clean) begin
        if (rst_clean) begin
            state <= 0; address <= 0; readEnable <= 0; writeEnable <= 0; writeData <= 0;
        end else begin
            case (state)
                3'd0: begin readEnable <= 0; writeEnable <= 0; state <= 3'd1; end
                3'd1: begin address <= 32'd4;   writeData <= {16'b0, switches}; writeEnable <= 1; readEnable <= 0; state <= 3'd2; end
                3'd2: begin address <= 32'd4;   writeEnable <= 0; readEnable <= 1; state <= 3'd3; end
                3'd3: begin address <= 32'd512; writeData <= {16'b0, switches}; writeEnable <= 1; readEnable <= 0; state <= 3'd4; end
                3'd4: begin address <= 32'd768; writeEnable <= 0; readEnable <= 1; state <= 3'd5; end
                3'd5: begin readEnable <= 0; writeEnable <= 0; state <= 3'd0; end
                default: state <= 3'd0;
            endcase
        end
    end
endmodule