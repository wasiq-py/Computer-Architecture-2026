module MainControl(input [6:0] opcode, output reg RegWrite, output reg [1:0] ALUOp, output reg MemRead, output reg MemWrite, output reg ALUSrc, output reg MemtoReg, output reg Branch );

always @(*) begin
    RegWrite = 0;
    ALUOp    = 2'b00;
    MemRead  = 0;
    MemWrite = 0;
    ALUSrc   = 0;
    MemtoReg = 0;
    Branch   = 0;

    case (opcode)
        7'b0110011: begin //r type instr
            RegWrite = 1;
            ALUOp    = 2'b10;
            ALUSrc   = 0;
        end

        7'b0010011: begin //addi
            RegWrite = 1;
            ALUOp    = 2'b00;
            ALUSrc   = 1;
        end

        7'b0000011: begin //load
            RegWrite = 1;
            ALUOp    = 2'b00;
            MemRead  = 1;
            ALUSrc   = 1;
            MemtoReg = 1;
        end

        7'b0100011: begin //store
            RegWrite = 0;
            ALUOp    = 2'b00;
            MemWrite = 1;
            ALUSrc   = 1;
        end

        7'b1100011: begin //beq
            RegWrite = 0;
            ALUOp    = 2'b01;
            ALUSrc   = 0;
            Branch   = 1;
        end

        default: begin
        end
    endcase
end

endmodule