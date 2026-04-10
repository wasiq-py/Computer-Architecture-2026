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
    // fibbionacci series
   // PC=0: addi x2, x0, 511
    memory[3]=8'h1F;
    memory[2]=8'hF0;
    memory[1]=8'h01;
    memory[0]=8'h13;
    // PC=4: addi x6, x0, 512
    memory[7]=8'h20;
    memory[6]=8'h00;
    memory[5]=8'h03;
    memory[4]=8'h13;
    // PC=8: addi x7, x0, 0    # prev = 0
    memory[11]=8'h00;
    memory[10]=8'h00;
    memory[9]=8'h03;
    memory[8]=8'h93;
    // PC=12: addi x8, x0, 1    # curr = 1
    memory[15]=8'h00;
    memory[14]=8'h10;
    memory[13]=8'h04;
    memory[12]=8'h13;
    // PC=16: addi x14, x0, 10  # count = 10
    memory[19]=8'h00;
    memory[18]=8'hA0;
    memory[17]=8'h07;
    memory[16]=8'h13;
    // PC=20: add x10, x8, x0   # a0 = curr
    memory[23]=8'h00;
    memory[22]=8'h04;
    memory[21]=8'h05;
    memory[20]=8'h33;
    // PC=24: jal x1, 48        # call display_and_delay at PC=72
    memory[27]=8'h03;
    memory[26]=8'h00;
    memory[25]=8'h00;
    memory[24]=8'hEF;
    // PC=28: add x9, x7, x8    # next = prev + curr
    memory[31]=8'h00;
    memory[30]=8'h83;
    memory[29]=8'h84;
    memory[28]=8'hB3;
    // PC=32: add x7, x8, x0    # prev = curr
    memory[35]=8'h00;
    memory[34]=8'h04;
    memory[33]=8'h03;
    memory[32]=8'hB3;
    // PC=36: add x8, x9, x0    # curr = next
    memory[39]=8'h00;
    memory[38]=8'h04;
    memory[37]=8'h84;
    memory[36]=8'h33;
    // PC=40: addi x14, x14, -1 # count--
    memory[43]=8'hFF;
    memory[42]=8'hF7;
    memory[41]=8'h07;
    memory[40]=8'h13;
    // PC=44: bne x14, x0, -24  # loop back to PC=20 if count != 0
    memory[47]=8'hFE;
    memory[46]=8'h07;
    memory[45]=8'h14;
    memory[44]=8'hE3;
    // PC=48: sw x0, 0(x6)      # clear LEDs
    memory[51]=8'h00;
    memory[50]=8'h03;
    memory[49]=8'h20;
    memory[48]=8'h23;
    // PC=52: jal x0, 0         # halt (infinite loop)
    memory[55]=8'h00;
    memory[54]=8'h00;
    memory[53]=8'h00;
    memory[52]=8'h6F;
    // PC=56-68: nop
    memory[59]=8'h00;
    memory[58]=8'h00;
    memory[57]=8'h00;
    memory[56]=8'h13;
    memory[63]=8'h00;
    memory[62]=8'h00;
    memory[61]=8'h00;
    memory[60]=8'h13;
    memory[67]=8'h00;
    memory[66]=8'h00;
    memory[65]=8'h00;
    memory[64]=8'h13;
    memory[71]=8'h00;
    memory[70]=8'h00;
    memory[69]=8'h00;
    memory[68]=8'h13;

    // this part saves ra and a0 on stack, displays a0 on LEDs, delays, restores, returns
    
    // PC=72: addi x2, x2, -8   # push stack
    memory[75]=8'hFF;
    memory[74]=8'h81;
    memory[73]=8'h01;
    memory[72]=8'h13;
    // PC=76: sw x1, 4(x2)      # save return address
    memory[79]=8'h00;
    memory[78]=8'h11;
    memory[77]=8'h22;
    memory[76]=8'h23;
    // PC=80: sw x10, 0(x2)     # save a0
    memory[83]=8'h00;
    memory[82]=8'hA1;
    memory[81]=8'h20;
    memory[80]=8'h23;
    // PC=84: sw x10, 0(x6)     # display a0 on LEDs
    memory[87]=8'h00;
    memory[86]=8'hA3;
    memory[85]=8'h20;
    memory[84]=8'h23;
    // PC=88: addi x13, x0, 5   # delay counter = 5
    memory[91]=8'h00;
    memory[90]=8'h50;
    memory[89]=8'h06;
    memory[88]=8'h93;
    // PC=92: addi x13, x13, -1 # delay--
    memory[95]=8'hFF;
    memory[94]=8'hF6;
    memory[93]=8'h86;
    memory[92]=8'h93;
    // PC=96: bne x13, x0, -4   # loop if delay != 0
    memory[99]=8'hFE;
    memory[98]=8'h06;
    memory[97]=8'h9E;
    memory[96]=8'hE3;
    // PC=100: lw x10, 0(x2)    # restore a0
    memory[103]=8'h00;
    memory[102]=8'h01;
    memory[101]=8'h25;
    memory[100]=8'h03;
    // PC=104: lw x1, 4(x2)     # restore return address
    memory[107]=8'h00;
    memory[106]=8'h41;
    memory[105]=8'h20;
    memory[104]=8'h83;
    // PC=108: addi x2, x2, 8   # pop stack
    memory[111]=8'h00;
    memory[110]=8'h81;
    memory[109]=8'h01;
    memory[108]=8'h13;
    // PC=112: jalr x0, 0(x1)   # return to caller
    memory[115]=8'h00;
    memory[114]=8'h00;
    memory[113]=8'h80;
    memory[112]=8'h67;
    end
endmodule
