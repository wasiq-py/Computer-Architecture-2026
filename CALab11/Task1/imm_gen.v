// ============================================
// Lab 11 - Task 1: imm_gen
// Single-cycle RISC-V processor component
// ============================================
module imm_gen(
    input [31:0] instr,
    output reg [31:0] imm_out
);
    wire [6:0] op = instr[6:0];
    
    // decode instruction format from opcode field
    always @(*) begin
        case(op)
            7'b0010011: // I-type arithmetic
                imm_out = {{20{instr[31]}}, instr[31:20]};
            7'b0000011: // I-type load
                imm_out = {{20{instr[31]}}, instr[31:20]};
            7'b1100111: // I-type JALR
                imm_out = {{20{instr[31]}}, instr[31:20]};
            7'b0100011: // S-type
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            7'b1100011: // B-type
                imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            7'b0110111: // U-type LUI
                imm_out = {instr[31:12], 12'b0};
            7'b1101111: // J-type JAL
                imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            default:
                imm_out = 32'b0;
        endcase
    end
endmodule
