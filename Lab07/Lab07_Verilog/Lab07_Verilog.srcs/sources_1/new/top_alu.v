module top_alu(
    input clk,
    input [15:0] switches,
    output [15:0] leds_out
);

wire rst = switches[15];

wire WriteEnable;
wire [4:0] rs1, rs2, rd;
wire [31:0] WriteData;
wire [3:0] ALUControl;
wire [4:0] state;

wire [31:0] ReadData1, ReadData2;
wire [31:0] ALUResult;
wire Zero;

RF_ALU_FSM fsm(
    .clk(clk),
    .rst(rst),
    .ALUResult(ALUResult),
    .Zero(Zero),
    .WriteEnable(WriteEnable),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ALUControl(ALUControl),
    .state(state)
);

regfile RF(
    .clk(clk),
    .rst(rst),
    .WriteEnable(WriteEnable),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .readData2(ReadData2)
);

ALU alu(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

assign leds_out[3:0]  = ALUResult[3:0];
assign leds_out[7:4]  = state[3:0];
assign leds_out[12:8] = rd;
assign leds_out[13]   = Zero;
assign leds_out[14]   = WriteEnable;
assign leds_out[15]   = rst;

endmodule