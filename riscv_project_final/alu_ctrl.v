// ============================================
// Lab 11 - Task 1: alu_ctrl
// Single-cycle RISC-V processor component
// ============================================
module alu_ctrl(
    input [1:0] alu_op,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ctrl_out
);
    // translate alu_op + funct fields to ALU operation
    always @(*) begin
        case(alu_op)
            2'b00: ctrl_out = 4'b0000; // ADD for load/store/JAL
            2'b01: ctrl_out = 4'b0001; // SUB for branch compare
            2'b10: case(funct3)        // R-type
                3'b000: ctrl_out = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB or ADD
                3'b110: ctrl_out = 4'b0011; // OR
                3'b111: ctrl_out = 4'b0010; // AND
                3'b100: ctrl_out = 4'b0100; // XOR
                3'b001: ctrl_out = 4'b0101; // SLL
                3'b101: ctrl_out = 4'b0110; // SRL
                3'b010: ctrl_out = 4'b0111; // SLT
                default: ctrl_out = 4'b0000;
            endcase
            2'b11: case(funct3)        // I-type arithmetic
                3'b000: ctrl_out = 4'b0000; // ADDI
                3'b110: ctrl_out = 4'b0011; // ORI
                3'b111: ctrl_out = 4'b0010; // ANDI
                3'b100: ctrl_out = 4'b0100; // XORI
                3'b001: ctrl_out = 4'b0101; // SLLI
                3'b101: ctrl_out = 4'b0110; // SRLI
                3'b010: ctrl_out = 4'b0111; // SLTI
                default: ctrl_out = 4'b0000;
            endcase
            default: ctrl_out = 4'b0000;
        endcase
    end
endmodule
