module instructionMemory#(
    parameter OPERAND_LENGTH = 31
    )(
    input  [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
    );
    reg [7:0] memory [0:255];

    always @(*) begin
        instruction = {memory[instAddress+3], memory[instAddress+2], memory[instAddress+1], memory[instAddress]};
    end
    initial begin
    // Test program for SLT, BGE, LUI
    // Expected LED sequence: 0x0001, 0x0000, 0x00AA, 0xE000

    // PC=0: addi x6, x0, 512       # LED address
    memory[3]=8'h20;memory[2]=8'h00;memory[1]=8'h03;memory[0]=8'h13;
    // PC=4: addi x7, x0, 5         # x7 = 5
    memory[7]=8'h00;memory[6]=8'h50;memory[5]=8'h03;memory[4]=8'h93;
    // PC=8: addi x8, x0, 10        # x8 = 10
    memory[11]=8'h00;memory[10]=8'hA0;memory[9]=8'h04;memory[8]=8'h13;

    // === TEST 1: SLT (5 < 10 = true → x9 = 1) ===
    // PC=12: slt x9, x7, x8
    memory[15]=8'h00;memory[14]=8'h83;memory[13]=8'hA4;memory[12]=8'hB3;
    // PC=16: sw x9, 0(x6)          # LEDs show 0x0001
    memory[19]=8'h00;memory[18]=8'h93;memory[17]=8'h20;memory[16]=8'h23;

    // Delay loop
    // PC=20: addi x13, x0, 5
    memory[23]=8'h00;memory[22]=8'h50;memory[21]=8'h06;memory[20]=8'h93;
    // PC=24: addi x13, x13, -1
    memory[27]=8'hFF;memory[26]=8'hF6;memory[25]=8'h86;memory[24]=8'h93;
    // PC=28: bne x13, x0, -4
    memory[31]=8'hFE;memory[30]=8'h06;memory[29]=8'h9E;memory[28]=8'hE3;

    // === TEST 1b: SLT (10 < 5 = false → x9 = 0) ===
    // PC=32: slt x9, x8, x7
    memory[35]=8'h00;memory[34]=8'h74;memory[33]=8'h24;memory[32]=8'hB3;
    // PC=36: sw x9, 0(x6)          # LEDs show 0x0000
    memory[39]=8'h00;memory[38]=8'h93;memory[37]=8'h20;memory[36]=8'h23;

    // Delay loop
    // PC=40: addi x13, x0, 5
    memory[43]=8'h00;memory[42]=8'h50;memory[41]=8'h06;memory[40]=8'h93;
    // PC=44: addi x13, x13, -1
    memory[47]=8'hFF;memory[46]=8'hF6;memory[45]=8'h86;memory[44]=8'h93;
    // PC=48: bne x13, x0, -4
    memory[51]=8'hFE;memory[50]=8'h06;memory[49]=8'h9E;memory[48]=8'hE3;

    // === TEST 2: BGE (10 >= 5, should skip PC=68) ===
    // PC=52: addi x7, x0, 10
    memory[55]=8'h00;memory[54]=8'hA0;memory[53]=8'h03;memory[52]=8'h93;
    // PC=56: addi x8, x0, 5
    memory[59]=8'h00;memory[58]=8'h50;memory[57]=8'h04;memory[56]=8'h13;
    // PC=60: addi x9, x0, 0xAA     # x9 = 170
    memory[63]=8'h0A;memory[62]=8'hA0;memory[61]=8'h04;memory[60]=8'h93;
    // PC=64: bge x7, x8, 8         # 10 >= 5 → branch to PC=72, skip next
    memory[67]=8'h00;memory[66]=8'h83;memory[65]=8'hD4;memory[64]=8'h63;
    // PC=68: addi x9, x0, 0xFF     # SKIPPED if BGE works
    memory[71]=8'h0F;memory[70]=8'hF0;memory[69]=8'h04;memory[68]=8'h93;
    // PC=72: sw x9, 0(x6)          # LEDs show 0x00AA (not 0xFF)
    memory[75]=8'h00;memory[74]=8'h93;memory[73]=8'h20;memory[72]=8'h23;

    // Delay loop
    // PC=76: addi x13, x0, 5
    memory[79]=8'h00;memory[78]=8'h50;memory[77]=8'h06;memory[76]=8'h93;
    // PC=80: addi x13, x13, -1
    memory[83]=8'hFF;memory[82]=8'hF6;memory[81]=8'h86;memory[80]=8'h93;
    // PC=84: bne x13, x0, -4
    memory[87]=8'hFE;memory[86]=8'h06;memory[85]=8'h9E;memory[84]=8'hE3;

    // === TEST 3: LUI (load 0xABCDE into upper 20 bits) ===
    // PC=88: lui x9, 0xABCDE       # x9 = 0xABCDE000
    memory[91]=8'hAB;memory[90]=8'hCD;memory[89]=8'hE4;memory[88]=8'hB7;
    // PC=92: sw x9, 0(x6)          # LEDs show lower 16 bits = 0xE000
    memory[95]=8'h00;memory[94]=8'h93;memory[93]=8'h20;memory[92]=8'h23;

    // Delay loop
    // PC=96: addi x13, x0, 5
    memory[99]=8'h00;memory[98]=8'h50;memory[97]=8'h06;memory[96]=8'h93;
    // PC=100: addi x13, x13, -1
    memory[103]=8'hFF;memory[102]=8'hF6;memory[101]=8'h86;memory[100]=8'h93;
    // PC=104: bne x13, x0, -4
    memory[107]=8'hFE;memory[106]=8'h06;memory[105]=8'h9E;memory[104]=8'hE3;

    // === END: infinite loop ===
    // PC=108: jal x0, 0
    memory[111]=8'h00;memory[110]=8'h00;memory[109]=8'h00;memory[108]=8'h6F;
    end
endmodule
