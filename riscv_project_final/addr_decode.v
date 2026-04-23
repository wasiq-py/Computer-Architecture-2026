// ============================================
// Lab 11 - Task 1: addr_decode
// Single-cycle RISC-V processor component
// ============================================
module addr_decode(
    input [9:0] addr,
    input rd_en,
    input wr_en,
    output dmem_wr,
    output dmem_rd,
    output led_wr,
    output sw_rd
);
    // top 2 bits of address select the device
    assign dmem_wr = wr_en & (addr[9:8] == 2'b00);
    assign dmem_rd = rd_en & (addr[9:8] == 2'b00);
    assign led_wr  = wr_en & (addr[9:8] == 2'b01);
    assign sw_rd   = rd_en & (addr[9:8] == 2'b10);
endmodule
