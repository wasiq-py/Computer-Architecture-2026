// ============================================
// Course Project - Part A & B
// FSM program from Lab 10 running on Lab 11 processor
// Added instructions: ANDI (I-type), BGE (B-type), 
//                     JAL (J-type)
// ============================================
module project_processor(
    input clk,
    input rst,
    input [15:0] switches,
    output reg [15:0] LEDs
);

// --- PC and instruction fetch ---
wire [31:0] pc_current, pc_seq, pc_branch, pc_jump;
wire [31:0] next_pc, instr;

// --- Instruction fields ---
wire [6:0]  opcode, funct7;
wire [4:0]  rs1_addr, rs2_addr, rd_addr;
wire [2:0]  funct3;

// --- Control signals ---
wire reg_wr, mem_rd, mem_wr, alu_src;
wire mem_to_reg, branch, jmp, jmp_reg;
wire [1:0] alu_op;

// --- Datapath signals ---
wire [31:0] rd_data1, rd_data2, imm_val;
wire [31:0] alu_b_in, alu_out, reg_wr_data;
wire [3:0]  ctrl_out;
wire        zero_flag;

// --- Memory and I/O ---
wire [31:0] dmem_rd_data, mem_rd_data;
wire        dmem_wr, dmem_rd, led_wr, sw_rd;
wire        branch_taken;

assign opcode   = instr[6:0];
assign rd_addr  = instr[11:7];
assign funct3   = instr[14:12];
assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
assign funct7   = instr[31:25];

assign branch_taken = branch & (
    (funct3 == 3'b000 &  zero_flag) |   // BEQ
    (funct3 == 3'b001 & ~zero_flag) |   // BNE
    (funct3 == 3'b101 & ~alu_out[31])   // BGE: branch if rs1 >= rs2 (result not negative) - Part B
);
assign pc_branch = pc_current + (imm_val << 1);
assign pc_jump   = pc_current + imm_val;
assign next_pc   = jmp_reg ? (rd_data1 + imm_val) :
                   jmp     ? pc_jump               :
                   branch_taken ? pc_branch        : pc_seq;

// JAL/JALR: save PC+4 as return address - Part B
assign reg_wr_data = (jmp | jmp_reg) ? pc_seq :
                      mem_to_reg     ? mem_rd_data : alu_out;

assign mem_rd_data = sw_rd ? {{16{1'b0}}, switches} : dmem_rd_data;

always @(posedge clk) begin
    if (rst) LEDs <= 16'b0;
    else if (led_wr) LEDs <= alu_out[15:0];
end

// fetch: update program counter
prog_counter PC_REG (
    .clk(clk), .rst(rst),
    .next_pc(next_pc), .pc_out(pc_current)
);

// fetch: PC + 4
pc_adder PC_PLUS4 (
    .pc_in(pc_current), .pc_seq(pc_seq)
);

// fetch: instruction memory - same program as Lab10
instruction_mem IMEM (
    .pc_addr(pc_current), .instr_out(instr)
);

// decode: generate immediate value
imm_gen IMM_GEN (
    .instr(instr), .imm_out(imm_val)
);

// ANDI supported via I-type path in alu_ctrl (funct3=111)
// decode: main control unit
main_ctrl CTRL (
    .opcode(opcode),
    .reg_wr(reg_wr), .mem_rd(mem_rd), .mem_wr(mem_wr),
    .alu_src(alu_src), .mem_to_reg(mem_to_reg),
    .branch(branch), .jmp(jmp), .jmp_reg(jmp_reg),
    .alu_op(alu_op)
);

// decode: register file
reg_file RF (
    .clk(clk), .rst(rst), .wr_en(reg_wr),
    .rs1(rs1_addr), .rs2(rs2_addr), .rd(rd_addr),
    .wr_data(reg_wr_data),
    .rd_data1(rd_data1), .rd_data2(rd_data2)
);

// execute: ALU input mux
mux_2to1 ALU_MUX (
    .in0(rd_data2), .in1(imm_val),
    .sel(alu_src), .mux_out(alu_b_in)
);

// execute: ALU control
alu_ctrl ALU_CTRL (
    .alu_op(alu_op), .funct3(funct3), .funct7(funct7),
    .ctrl_out(ctrl_out)
);

// execute: ALU
alu_unit ALU (
    .A(rd_data1), .B(alu_b_in),
    .alu_ctrl(ctrl_out),
    .alu_result(alu_out), .zero_flag(zero_flag)
);

// memory: address decoder
addr_decode ADEC (
    .addr(alu_out[9:0]),
    .rd_en(mem_rd), .wr_en(mem_wr),
    .dmem_wr(dmem_wr), .dmem_rd(dmem_rd),
    .led_wr(led_wr), .sw_rd(sw_rd)
);

// memory: data memory
data_mem DMEM (
    .clk(clk), .mem_wr(dmem_wr),
    .addr(alu_out[8:0]),
    .wr_data(rd_data2), .rd_data(dmem_rd_data)
);

endmodule
