// ============================================
// Lab 11 - Task 1: prog_counter
// Single-cycle RISC-V processor component
// ============================================
module prog_counter(
    input clk,
    input rst,
    input [31:0] next_pc,
    output reg [31:0] pc_out
);
    // update PC on every rising edge
    always @(posedge clk) begin
        if (rst == 1'b1)
            pc_out <= 32'b0;
        else
            pc_out <= next_pc;
    end
endmodule
