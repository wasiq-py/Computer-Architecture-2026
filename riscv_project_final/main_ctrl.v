// ============================================
// Lab 11 - Task 1: main_ctrl
// Single-cycle RISC-V processor component
// ============================================
module main_ctrl(
    input [6:0] opcode,
    output reg reg_wr,
    output reg mem_rd,
    output reg mem_wr,
    output reg alu_src,
    output reg mem_to_reg,
    output reg branch,
    output reg jmp,
    output reg jmp_reg,
    output reg [1:0] alu_op
);
    // decode opcode to drive the whole datapath
    always @(*) begin
        case(opcode)
            7'b0110011: begin // R-type
                reg_wr = 1'b1; alu_src = 1'b0; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b10;
            end
            7'b0010011: begin // I-type arithmetic
                reg_wr = 1'b1; alu_src = 1'b1; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b11;
            end
            7'b0000011: begin // Load
                reg_wr = 1'b1; alu_src = 1'b1; mem_rd = 1'b1; mem_wr = 1'b0;
                mem_to_reg = 1'b1; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b00;
            end
            7'b0100011: begin // Store
                reg_wr = 1'b0; alu_src = 1'b1; mem_rd = 1'b0; mem_wr = 1'b1;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b00;
            end
            7'b1100011: begin // Branch
                reg_wr = 1'b0; alu_src = 1'b0; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b1; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b01;
            end
            7'b1101111: begin // JAL
                reg_wr = 1'b1; alu_src = 1'b0; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b1; jmp_reg = 1'b0; alu_op = 2'b00;
            end
            7'b1100111: begin // JALR
                reg_wr = 1'b1; alu_src = 1'b1; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b1; alu_op = 2'b00;
            end
            7'b0110111: begin // LUI
                reg_wr = 1'b1; alu_src = 1'b0; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b00;
            end
            default: begin // all signals = 0
                reg_wr = 1'b0; alu_src = 1'b0; mem_rd = 1'b0; mem_wr = 1'b0;
                mem_to_reg = 1'b0; branch = 1'b0; jmp = 1'b0; jmp_reg = 1'b0; alu_op = 2'b00;
            end
        endcase
    end
endmodule
