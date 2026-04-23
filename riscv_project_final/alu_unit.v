// ============================================
// Lab 11 - Task 1: alu_unit
// Single-cycle RISC-V processor component
// ============================================
module alu_unit(
    input [31:0] A,
    input [31:0] B,
    input [3:0] alu_ctrl,
    output reg [31:0] alu_result,
    output zero_flag
);
    assign zero_flag = (alu_result == 32'b0);
    
    // pick operation based on control signal
    always @(*) begin
        case(alu_ctrl)
            4'b0000: alu_result = A + B;          // ADD
            4'b0001: alu_result = A - B;          // SUB
            4'b0010: alu_result = A & B;          // AND
            4'b0011: alu_result = A | B;          // OR
            4'b0100: alu_result = A ^ B;          // XOR
            4'b0101: alu_result = A << B[4:0];    // SLL
            4'b0110: alu_result = A >> B[4:0];    // SRL
            4'b0111: alu_result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
            default: alu_result = 32'b0;
        endcase
    end
endmodule
