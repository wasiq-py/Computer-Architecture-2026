// ============================================
// Lab 10 - Task 3: Instruction Memory Module
// Stores FSM assembly program machine code
// Byte-addressable, little-endian, 27 instructions
// PC increments by 4 each cycle
//
// FIX: Corrected I/O addresses:
//   x5 = 512 (0x200) -> switch input  (addr[9:8]=10)
//   x6 = 256 (0x100) -> LED output    (addr[9:8]=01)
// ============================================

module instruction_mem #(
    parameter ADDR_BITS = 8
)(
    input [31:0] pc_addr,
    output reg [31:0] instr_out
);

    // Internal storage: 256 bytes
    reg [7:0] mem_bytes [0:255];
    integer i;

    initial begin
        // addi x28, x0, 7
        mem_bytes[0]  = 8'h13;
        mem_bytes[1]  = 8'h0E;
        mem_bytes[2]  = 8'h70;
        mem_bytes[3]  = 8'h00;

        // addi x2, x0, 511   (stack pointer)
        mem_bytes[4]  = 8'h13;
        mem_bytes[5]  = 8'h01;
        mem_bytes[6]  = 8'hF0;
        mem_bytes[7]  = 8'h1F;

        // addi x5, x0, 512   (switch address 0x200 -> addr[9:8]=10 -> sw_rd)  [FIXED: was 768]
        mem_bytes[8]  = 8'h93;
        mem_bytes[9]  = 8'h02;
        mem_bytes[10] = 8'h00;
        mem_bytes[11] = 8'h20;

        // addi x6, x0, 256   (LED address 0x100 -> addr[9:8]=01 -> led_wr)  [FIXED: was 512]
        mem_bytes[12] = 8'h13;
        mem_bytes[13] = 8'h03;
        mem_bytes[14] = 8'h00;
        mem_bytes[15] = 8'h10;

        // sw x28, 0(x5)   (store initial display value to switch port - write to dmem)
        mem_bytes[16] = 8'h23;
        mem_bytes[17] = 8'hA0;
        mem_bytes[18] = 8'hC2;
        mem_bytes[19] = 8'h01;

        // sw x0, 0(x6) - WAIT_STATE  (clear LEDs)
        mem_bytes[20] = 8'h23;
        mem_bytes[21] = 8'h20;
        mem_bytes[22] = 8'h03;
        mem_bytes[23] = 8'h00;

        // lw x11, 0(x5) - SWITCH_POLL  (read switches)
        mem_bytes[24] = 8'h83;
        mem_bytes[25] = 8'hA5;
        mem_bytes[26] = 8'h02;
        mem_bytes[27] = 8'h00;

        // beq x11, x0, SWITCH_POLL  (loop if no switch pressed)
        mem_bytes[28] = 8'hE3;
        mem_bytes[29] = 8'h8E;
        mem_bytes[30] = 8'h05;
        mem_bytes[31] = 8'hFE;

        // add x10, x11, x0  (copy switch value to x10)
        mem_bytes[32] = 8'h33;
        mem_bytes[33] = 8'h85;
        mem_bytes[34] = 8'h05;
        mem_bytes[35] = 8'h00;

        // jal x1, START_COUNT  (call countdown subroutine)
        mem_bytes[36] = 8'hEF;
        mem_bytes[37] = 8'h00;
        mem_bytes[38] = 8'h80;
        mem_bytes[39] = 8'h00;

        // jal x0, WAIT_STATE  (loop back)
        mem_bytes[40] = 8'h6F;
        mem_bytes[41] = 8'hF0;
        mem_bytes[42] = 8'hDF;
        mem_bytes[43] = 8'hFE;

        // addi x2, x2, -8 - START_COUNT  (allocate stack frame)
        mem_bytes[44] = 8'h13;
        mem_bytes[45] = 8'h01;
        mem_bytes[46] = 8'h81;
        mem_bytes[47] = 8'hFF;

        // sw x1, 4(x2)  (save return address)
        mem_bytes[48] = 8'h23;
        mem_bytes[49] = 8'h22;
        mem_bytes[50] = 8'h11;
        mem_bytes[51] = 8'h00;

        // sw x12, 0(x2)  (save x12)
        mem_bytes[52] = 8'h23;
        mem_bytes[53] = 8'h20;
        mem_bytes[54] = 8'hC1;
        mem_bytes[55] = 8'h00;

        // add x12, x10, x0  (x12 = countdown start value)
        mem_bytes[56] = 8'h33;
        mem_bytes[57] = 8'h06;
        mem_bytes[58] = 8'h05;
        mem_bytes[59] = 8'h00;

        // sw x12, 0(x6) - COUNT_LOOP  (display current count on LEDs)
        mem_bytes[60] = 8'h23;
        mem_bytes[61] = 8'h20;
        mem_bytes[62] = 8'hC3;
        mem_bytes[63] = 8'h00;

        // beq x12, x0, COUNT_DONE  (if count=0, done)
        mem_bytes[64] = 8'h63;
        mem_bytes[65] = 8'h0C;
        mem_bytes[66] = 8'h06;
        mem_bytes[67] = 8'h00;

        // addi x12, x12, -1  (decrement count)
        mem_bytes[68] = 8'h13;
        mem_bytes[69] = 8'h06;
        mem_bytes[70] = 8'hF6;
        mem_bytes[71] = 8'hFF;

        // addi x13, x0, 4  (delay counter)
        mem_bytes[72] = 8'h93;
        mem_bytes[73] = 8'h06;
        mem_bytes[74] = 8'h40;
        mem_bytes[75] = 8'h00;

        // addi x13, x13, -1 - DELAY_LOOP
        mem_bytes[76] = 8'h93;
        mem_bytes[77] = 8'h86;
        mem_bytes[78] = 8'hF6;
        mem_bytes[79] = 8'hFF;

        // bne x13, x0, DELAY_LOOP
        mem_bytes[80] = 8'hE3;
        mem_bytes[81] = 8'h9E;
        mem_bytes[82] = 8'h06;
        mem_bytes[83] = 8'hFE;

        // jal x0, COUNT_LOOP
        mem_bytes[84] = 8'h6F;
        mem_bytes[85] = 8'hF0;
        mem_bytes[86] = 8'h9F;
        mem_bytes[87] = 8'hFE;

        // sw x0, 0(x6) - COUNT_DONE  (clear LEDs when done)
        mem_bytes[88] = 8'h23;
        mem_bytes[89] = 8'h20;
        mem_bytes[90] = 8'h03;
        mem_bytes[91] = 8'h00;

        // lw x12, 0(x2)  (restore x12)
        mem_bytes[92] = 8'h03;
        mem_bytes[93] = 8'h26;
        mem_bytes[94] = 8'h01;
        mem_bytes[95] = 8'h00;

        // lw x1, 4(x2)  (restore return address)
        mem_bytes[96] = 8'h83;
        mem_bytes[97] = 8'h20;
        mem_bytes[98] = 8'h41;
        mem_bytes[99] = 8'h00;

        // addi x2, x2, 8  (deallocate stack frame)
        mem_bytes[100] = 8'h13;
        mem_bytes[101] = 8'h01;
        mem_bytes[102] = 8'h81;
        mem_bytes[103] = 8'h00;

        // jalr x0, 0(x1)  (return)
        mem_bytes[104] = 8'h67;
        mem_bytes[105] = 8'h80;
        mem_bytes[106] = 8'h00;
        mem_bytes[107] = 8'h00;

        for (i = 108; i < 256; i = i + 1) mem_bytes[i] = 8'h00;
    end

    always @(*) begin
        // read 4 bytes starting at pc and assemble instruction
        instr_out = {mem_bytes[pc_addr+3], mem_bytes[pc_addr+2],
                     mem_bytes[pc_addr+1], mem_bytes[pc_addr]};
    end

endmodule
