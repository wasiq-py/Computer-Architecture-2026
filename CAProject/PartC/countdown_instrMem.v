// ============================================
// Project Part C: Countdown Demo Instruction Memory
// Stores loop-based countdown program
// Byte-addressable, little-endian
// ============================================

module countdown_instrMem #(
    parameter ADDR_BITS = 8
)(
    input [31:0] pc_addr,
    output reg [31:0] instr_out
);

    // Internal storage: 256 bytes
    reg [7:0] mem_bytes [0:255];
    integer i;

    initial begin
        // addi x6, x0, 512
        mem_bytes[0]  = 8'h13;
        mem_bytes[1]  = 8'h03;
        mem_bytes[2]  = 8'h00;
        mem_bytes[3]  = 8'h20;

        // addi x7, x0, 15
        mem_bytes[4]  = 8'h93;
        mem_bytes[5]  = 8'h03;
        mem_bytes[6]  = 8'hF0;
        mem_bytes[7]  = 8'h00;

        // add x8, x7, x0
        mem_bytes[8]  = 8'h33;
        mem_bytes[9]  = 8'h84;
        mem_bytes[10] = 8'h03;
        mem_bytes[11] = 8'h00;

        // sw x8, 0(x6)
        mem_bytes[12] = 8'h23;
        mem_bytes[13] = 8'h20;
        mem_bytes[14] = 8'h83;
        mem_bytes[15] = 8'h00;

        // beq x8, x0, RESET_COUNT
        mem_bytes[16] = 8'h63;
        mem_bytes[17] = 8'h0C;
        mem_bytes[18] = 8'h04;
        mem_bytes[19] = 8'h00;

        // addi x8, x8, -1
        mem_bytes[20] = 8'h13;
        mem_bytes[21] = 8'h04;
        mem_bytes[22] = 8'hF4;
        mem_bytes[23] = 8'hFF;

        // addi x9, x0, 6
        mem_bytes[24] = 8'h93;
        mem_bytes[25] = 8'h04;
        mem_bytes[26] = 8'h60;
        mem_bytes[27] = 8'h00;

        // addi x9, x9, -1
        mem_bytes[28] = 8'h93;
        mem_bytes[29] = 8'h84;
        mem_bytes[30] = 8'hF4;
        mem_bytes[31] = 8'hFF;

        // bne x9, x0, INNER_DELAY
        mem_bytes[32] = 8'hE3;
        mem_bytes[33] = 8'h9E;
        mem_bytes[34] = 8'h04;
        mem_bytes[35] = 8'hFE;

        // jal x0, COUNT_DOWN
        mem_bytes[36] = 8'h6F;
        mem_bytes[37] = 8'hF0;
        mem_bytes[38] = 8'h9F;
        mem_bytes[39] = 8'hFE;

        // sw x0, 0(x6)
        mem_bytes[40] = 8'h23;
        mem_bytes[41] = 8'h20;
        mem_bytes[42] = 8'h03;
        mem_bytes[43] = 8'h00;

        // jal x0, OUTER_LOOP
        mem_bytes[44] = 8'h6F;
        mem_bytes[45] = 8'hF0;
        mem_bytes[46] = 8'hDF;
        mem_bytes[47] = 8'hFD;

        for (i = 48; i < 256; i = i + 1) mem_bytes[i] = 8'h00;
    end

    always @(*) begin
        // read 4 bytes starting at pc and assemble instruction
        instr_out = {mem_bytes[pc_addr+3], mem_bytes[pc_addr+2],
                     mem_bytes[pc_addr+1], mem_bytes[pc_addr]};
    end

endmodule
