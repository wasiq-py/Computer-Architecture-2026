`timescale 1ns / 1ps

module TopLevelProcessor(
    input clk,
    input rst,
    input [15:0] switches,
    output [15:0] LEDs
);

wire [31:0] PC, PCplus4, branchTarget, jumpTarget;
wire [31:0] instruction, imm;
wire [31:0] ReadData1, readData2;
wire [31:0] ALUinB, ALUResult;
wire [31:0] memReadData, writeBackData, regWriteData;
wire Zero;
wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, Jump, JumpReg, LUI;
wire [1:0] ALUOp;
wire [3:0] ALUCtrl;
wire [2:0] funct3;
wire [6:0] funct7;

assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];
wire DataMemWrite, DataMemRead, LEDWrite, SwitchReadEnable;
wire branchTaken = Branch & (
    (funct3 == 3'b000 & Zero) |          // BEQ
    (funct3 == 3'b001 & ~Zero) |         // BNE
    (funct3 == 3'b101 & ~ALUResult[31])  // BGE (NEW)
);
pcAdder pa(.PC(PC), .PCplus4(PCplus4));
branchAdder ba(.PC(PC), .imm(imm), .branchTarget(branchTarget));
assign jumpTarget = ReadData1 + imm;
wire [31:0] nextPC;
assign nextPC = (JumpReg) ? jumpTarget :
                (Jump) ? branchTarget :
                (branchTaken) ? branchTarget :
                PCplus4;

ProgramCounter pc(.clk(clk), .rst(rst), .nextPC(nextPC), .PC(PC));
instructionMemory im(.instAddress(PC), .instruction(instruction));
immGen ig(.instruction(instruction), .imm(imm));
MainControl mc(.opcode(instruction[6:0]), .RegWrite(RegWrite), .ALUOp(ALUOp), .MemRead(MemRead), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .Branch(Branch), .Jump(Jump), .JumpReg(JumpReg), .LUI(LUI));
assign regWriteData = (Jump | JumpReg) ? PCplus4 : (LUI ? imm : writeBackData);
RegisterFile rf(.clk(clk), .rst(rst), .WriteEnable(RegWrite), .rs1(instruction[19:15]), .rs2(instruction[24:20]), .rd(instruction[11:7]), .WriteData(regWriteData), .ReadData1(ReadData1), .readData2(readData2));
mux2 m(.a(readData2), .b(imm), .sel(ALUSrc), .out(ALUinB));
ALUControl ac(.ALUOp(ALUOp), .funct3(funct3), .funct7(funct7), .ALUControl(ALUCtrl));
ALU a(.A(ReadData1), .B(ALUinB), .ALUControl(ALUCtrl), .ALUResult(ALUResult), .Zero(Zero));
AddressDecoder ad(.address(ALUResult[9:0]), .readEnable(MemRead), .writeEnable(MemWrite), .DataMemWrite(DataMemWrite), .DataMemRead(DataMemRead), .LEDWrite(LEDWrite), .SwitchReadEnable(SwitchReadEnable));

wire [31:0] dmemReadData;
DataMemory dm(.clk(clk), .MemWrite(DataMemWrite), .address(ALUResult[8:0]), .write_data(readData2), .read_data(dmemReadData));

reg [15:0] ledReg;
always @(posedge clk) begin
    if (rst)
        ledReg <= 16'd0;
    else if (LEDWrite)
        ledReg <= readData2[15:0];
end
assign LEDs = ledReg;
assign memReadData = SwitchReadEnable ? {16'd0, switches} : dmemReadData;
mux2 m2( .a(ALUResult), .b(memReadData), .sel(MemtoReg), .out(writeBackData));

endmodule
