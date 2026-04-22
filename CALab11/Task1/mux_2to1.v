// ============================================
// Lab 11 - Task 1: mux_2to1
// Single-cycle RISC-V processor component
// ============================================
module mux_2to1(
    input [31:0] in0,
    input [31:0] in1,
    input sel,
    output [31:0] mux_out
);
    // sel=0 takes sequential PC, sel=1 takes branch
    assign mux_out = sel ? in1 : in0;
endmodule
