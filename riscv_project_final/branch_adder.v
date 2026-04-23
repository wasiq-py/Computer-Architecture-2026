// ============================================
// Lab 11 - Task 1: branch_adder
// Single-cycle RISC-V processor component
//
// FIX: Removed extra (imm_val << 1) shift.
// imm_gen B-type output already encodes the full byte offset
// (it appends 1'b0 at bit[0] internally), so no further shift needed here.
// Was: b_target = pc_in + (imm_val << 1)  -> doubled the offset (bug)
// Now: b_target = pc_in + imm_val          -> correct byte offset
// ============================================
module branch_adder(
    input [31:0] pc_in,
    input [31:0] imm_val,
    output [31:0] b_target
);
    // branch target = PC + immediate (already a full byte offset from imm_gen)
    assign b_target = pc_in + imm_val;
endmodule
