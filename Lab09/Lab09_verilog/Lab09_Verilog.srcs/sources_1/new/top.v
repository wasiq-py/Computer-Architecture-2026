`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2026 10:55:22 AM
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


module top(
    input clk,
    input rst,
    input btn,
    input [15:0] sw,
    output reg [15:0] led
);

    wire dbtn;
    reg dbtn_d;
    wire btn_pulse;
    reg [6:0] opcode_reg;
    reg [2:0] funct3_reg;
    reg [6:0] funct7_reg;

    reg [1:0] state;

    wire RegWrite;
    wire [1:0] ALUOp;
    wire MemRead, MemWrite, ALUSrc, MemtoReg, Branch;
    wire [3:0] ALUControl_out;
    debouncer d1(
        .clk(clk),
        .pbin(btn),
        .pbout(dbtn)
    );
    
    always @(posedge clk) begin
        dbtn_d <= dbtn;
    end

    assign btn_pulse = dbtn & ~dbtn_d;
    
    MainControl m1(
        .opcode(opcode_reg),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .Branch(Branch)
    );

    ALUControl a1(
        .ALUOp(ALUOp),
        .funct3(funct3_reg),
        .funct7(funct7_reg),
        .ALUControl(ALUControl_out)
    );

    always @(posedge clk) begin
        if (rst) begin
            state <= 2'b00;
            opcode_reg <= 7'b0;
            funct3_reg <= 3'b0;
            funct7_reg <= 7'b0;
        end
        else if (btn_pulse) begin
            case (state)
                2'b00: begin
                    opcode_reg <= sw[6:0];
                    state <= 2'b01;
                end

                2'b01: begin
                    funct3_reg <= sw[2:0];
                    state <= 2'b10;
                end

                2'b10: begin
                    funct7_reg <= sw[6:0];
                    state <= 2'b11;
                end

                2'b11: begin
                    state <= 2'b00;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            2'b00: begin
                led = 16'b0;
                led[15:12] = 4'b0001;
                led[6:0] = sw[6:0];
            end

            2'b01: begin
                led = 16'b0;
                led[15:12] = 4'b0010;
                led[2:0] = sw[2:0];
            end

            2'b10: begin
                led = 16'b0;
                led[15:12] = 4'b0100;
                led[6:0] = sw[6:0];
            end

            2'b11: begin
                led = 16'b0;
                led[15:12] = 4'b1000;
                led[0] = RegWrite;
                led[1] = MemRead;
                led[2] = MemWrite;
                led[3] = ALUSrc;
                led[4] = MemtoReg;
                led[5] = Branch;
                led[7:6] = ALUOp;
                led[11:8] = ALUControl_out;
            end
        endcase
    end

endmodule
