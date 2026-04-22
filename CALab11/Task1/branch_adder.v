// ============================================
// Lab 11 - Task 1: branch_adder
// Single-cycle RISC-V processor component
// ============================================
module branch_adder(
    input [31:0] pc_in,
    input [31:0] imm_val,
    output [31:0] b_target
);
    // branch target = PC + immediate shifted left by 1
    assign b_target = pc_in + (imm_val << 1);
endmodule
