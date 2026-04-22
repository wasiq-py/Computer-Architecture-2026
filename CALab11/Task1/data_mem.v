// ============================================
// Lab 11 - Task 1: data_mem
// Single-cycle RISC-V processor component
// ============================================
module data_mem(
    input clk,
    input mem_wr,
    input [8:0] addr,
    input [31:0] wr_data,
    output [31:0] rd_data
);
    reg [31:0] mem_array [0:511];
    
    assign rd_data = mem_array[addr];
    
    // write only, reads are combinational
    always @(posedge clk) begin
        if (mem_wr) begin
            mem_array[addr] <= wr_data;
        end
    end
endmodule
