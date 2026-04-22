// ============================================
// Lab 11 - Task 1: pc_adder
// Single-cycle RISC-V processor component
// ============================================
module pc_adder(
    input [31:0] pc_in,
    output [31:0] pc_seq
);
    // always 4 bytes ahead, no clock needed
    assign pc_seq = pc_in + 32'd4;
endmodule
