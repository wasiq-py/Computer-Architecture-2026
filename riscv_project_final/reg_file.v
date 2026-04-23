// ============================================
// Lab 11 - Task 1: reg_file
// Single-cycle RISC-V processor component
// ============================================
module reg_file(
    input clk,
    input rst,
    input wr_en,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wr_data,
    output [31:0] rd_data1,
    output [31:0] rd_data2
);
    reg [31:0] regs [31:0];
    integer j;
    
    assign rd_data1 = (rs1 == 5'b0) ? 32'b0 : regs[rs1];
    assign rd_data2 = (rs2 == 5'b0) ? 32'b0 : regs[rs2];
    
    // write on clock edge, reads are instant
    always @(posedge clk) begin
        if (rst) begin
            for (j = 0; j < 32; j = j + 1) begin
                regs[j] <= 32'b0;
            end
        end else if (wr_en && rd != 5'b0) begin
            regs[rd] <= wr_data;
        end
    end
endmodule
