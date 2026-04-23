// ============================================
// Fibonacci Sequence Instruction Memory
// Stores a Fibonacci generation program
// Byte-addressable, little-endian
// ============================================

module fibonacci_instrMem #(
    parameter ADDR_BITS = 8
)(
    input [31:0] pc_addr,
    output reg [31:0] instr_out
);

    reg [7:0] mem_bytes [0:255];
    integer i;

    initial begin
        // addi x2, x0, 511
        mem_bytes[0]  = 8'h13; mem_bytes[1]  = 8'h01; mem_bytes[2]  = 8'hF0; mem_bytes[3]  = 8'h1F;
        // addi x6, x0, 256
        mem_bytes[4]  = 8'h13; mem_bytes[5]  = 8'h03; mem_bytes[6]  = 8'h00; mem_bytes[7]  = 8'h10;
        // addi x7, x0, 0
        mem_bytes[8]  = 8'h93; mem_bytes[9]  = 8'h03; mem_bytes[10] = 8'h00; mem_bytes[11] = 8'h00;
        // addi x8, x0, 1
        mem_bytes[12] = 8'h13; mem_bytes[13] = 8'h04; mem_bytes[14] = 8'h10; mem_bytes[15] = 8'h00;
        // addi x14, x0, 10
        mem_bytes[16] = 8'h13; mem_bytes[17] = 8'h07; mem_bytes[18] = 8'hA0; mem_bytes[19] = 8'h00;
        
        // loop: (PC = 20)
        // add x10, x8, x0
        mem_bytes[20] = 8'h33; mem_bytes[21] = 8'h05; mem_bytes[22] = 8'h04; mem_bytes[23] = 8'h00;
        // jal x1, display
        mem_bytes[24] = 8'hEF; mem_bytes[25] = 8'h00; mem_bytes[26] = 8'h00; mem_bytes[27] = 8'h02;
        // add x9, x7, x8
        mem_bytes[28] = 8'hB3; mem_bytes[29] = 8'h84; mem_bytes[30] = 8'h83; mem_bytes[31] = 8'h00;
        // add x7, x8, x0
        mem_bytes[32] = 8'hB3; mem_bytes[33] = 8'h03; mem_bytes[34] = 8'h04; mem_bytes[35] = 8'h00;
        // add x8, x9, x0
        mem_bytes[36] = 8'h33; mem_bytes[37] = 8'h84; mem_bytes[38] = 8'h04; mem_bytes[39] = 8'h00;
        // addi x14, x14, -1
        mem_bytes[40] = 8'h13; mem_bytes[41] = 8'h07; mem_bytes[42] = 8'hF7; mem_bytes[43] = 8'hFF;
        // bne x14, x0, loop
        mem_bytes[44] = 8'h63; mem_bytes[45] = 8'h1A; mem_bytes[46] = 8'h07; mem_bytes[47] = 8'hFE;
        // sw x0, 0(x6)
        mem_bytes[48] = 8'h23; mem_bytes[49] = 8'h20; mem_bytes[50] = 8'h03; mem_bytes[51] = 8'h00;
        // jal x0, 0
        mem_bytes[52] = 8'h6F; mem_bytes[53] = 8'h00; mem_bytes[54] = 8'h00; mem_bytes[55] = 8'h00;
        
        // display subroutine: (PC = 56)
        // addi x2, x2, -8
        mem_bytes[56] = 8'h13; mem_bytes[57] = 8'h01; mem_bytes[58] = 8'h81; mem_bytes[59] = 8'hFF;
        // sw x1, 4(x2)
        mem_bytes[60] = 8'h23; mem_bytes[61] = 8'h22; mem_bytes[62] = 8'h11; mem_bytes[63] = 8'h00;
        // sw x10, 0(x2)
        mem_bytes[64] = 8'h23; mem_bytes[65] = 8'h20; mem_bytes[66] = 8'hA1; mem_bytes[67] = 8'h00;
        // sw x10, 0(x6)
        mem_bytes[68] = 8'h23; mem_bytes[69] = 8'h20; mem_bytes[70] = 8'hA3; mem_bytes[71] = 8'h00;
        // addi x13, x0, 5
        mem_bytes[72] = 8'h93; mem_bytes[73] = 8'h06; mem_bytes[74] = 8'h50; mem_bytes[75] = 8'h00;
        
        // delay: (PC = 76)
        // addi x13, x13, -1
        mem_bytes[76] = 8'h93; mem_bytes[77] = 8'h86; mem_bytes[78] = 8'hF6; mem_bytes[79] = 8'hFF;
        // bne x13, x0, delay
        mem_bytes[80] = 8'h63; mem_bytes[81] = 8'h9E; mem_bytes[82] = 8'h06; mem_bytes[83] = 8'hFE;
        // lw x10, 0(x2)
        mem_bytes[84] = 8'h03; mem_bytes[85] = 8'h25; mem_bytes[86] = 8'h00; mem_bytes[87] = 8'h00;
        // lw x1, 4(x2)
        mem_bytes[88] = 8'h83; mem_bytes[89] = 8'h20; mem_bytes[90] = 8'h41; mem_bytes[91] = 8'h00;
        // addi x2, x2, 8
        mem_bytes[92] = 8'h13; mem_bytes[93] = 8'h01; mem_bytes[94] = 8'h81; mem_bytes[95] = 8'h00;
        // jalr x0, 0(x1)
        mem_bytes[96] = 8'h67; mem_bytes[97] = 8'h80; mem_bytes[98] = 8'h00; mem_bytes[99] = 8'h00;

        for (i = 100; i < 256; i = i + 1) mem_bytes[i] = 8'h00;
    end

    always @(*) begin
        instr_out = {mem_bytes[pc_addr+3], mem_bytes[pc_addr+2],
                     mem_bytes[pc_addr+1], mem_bytes[pc_addr]};
    end
endmodule
