module top_alu(
    input clk,
    input [15:0] switches,
    output [15:0] leds_out
);

wire rst = switches[15];

wire [4:0] state;
wire init_done;
wire WE_init;
wire [4:0] rd_init;
wire [31:0] WD_init;

RF_ALU_FSM fsm(
    .clk(clk),
    .rst(rst),
    .state(state),
    .init_done(init_done),
    .WriteEnable_init(WE_init),
    .rd_init(rd_init),
    .WriteData_init(WD_init)
);

wire [31:0] ReadData1, ReadData2;
wire [31:0] ALUResult;
wire Zero;

wire WE = init_done ? switches[13] : WE_init;
wire [4:0] rd = init_done ? switches[12:8] : rd_init;
wire [31:0] WD = init_done ? ALUResult : WD_init;

regfile RF(
    .clk(clk),
    .rst(rst),
    .WriteEnable(WE),
    .rs1(5'd1),
    .rs2(5'd2),
    .rd(rd),
    .WriteData(WD),
    .ReadData1(ReadData1),
    .readData2(ReadData2)
);

ALU alu(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(switches[3:0]),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

assign leds_out[3:0] = ALUResult[3:0];
assign leds_out[7:4] = state[3:0];
assign leds_out[12:8] = rd;
assign leds_out[13] = Zero;
assign leds_out[14] = WE;
assign leds_out[15] = rst;

endmodule