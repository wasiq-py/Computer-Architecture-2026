`timescale 1ns / 1ps

module MainControl(
    input [6:0] opcode,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output reg MemRead, MemWrite, ALUSrc, MemtoReg, Branch,
    output reg Jump, JumpReg
    );
    always@(*) begin
    RegWrite = 1'b0;
    ALUOp = 2'b00;
    MemRead = 1'b0;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    MemtoReg = 1'b0;
    Branch = 1'b0;
    Jump = 1'b0;
    JumpReg = 1'b0;

    case (opcode)
        7'b0110011: begin // R-type
            RegWrite = 1'b1;
            ALUOp = 2'b10;
        end

        7'b0010011: begin // I-type ALU
            RegWrite = 1'b1;
            ALUOp = 2'b10;
            ALUSrc = 1'b1;
        end

        7'b0000011: begin // Load
            RegWrite = 1'b1;
            ALUOp = 2'b00;
            MemRead = 1'b1;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
        end

        7'b0100011: begin // Store
            ALUOp = 2'b00;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
        end

        7'b1100011: begin // Branch
            ALUOp = 2'b01;
            Branch = 1'b1;
        end

        7'b1101111: begin // JAL
            RegWrite = 1'b1;
            Jump = 1'b1;
        end

        7'b1100111: begin // JALR
            RegWrite = 1'b1;
            ALUSrc = 1'b1;
            JumpReg = 1'b1;
        end
    endcase
    end
endmodule
