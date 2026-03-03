module RF_ALU_FSM(
    input clk,
    input rst,
    output reg [4:0] state,
    output reg init_done,
    output reg WriteEnable_init,
    output reg [4:0] rd_init,
    output reg [31:0] WriteData_init
);

always @(posedge clk) begin
    if (rst) begin
        state <= 0;
        init_done <= 0;
    end else begin
        case(state)
            0: begin
                WriteEnable_init <= 1;
                rd_init <= 5'd1;
                WriteData_init <= 32'h10101010;
                state <= 1;
            end
            1: begin
                WriteEnable_init <= 1;
                rd_init <= 5'd2;
                WriteData_init <= 32'h01010101;
                state <= 2;
            end
            2: begin
                WriteEnable_init <= 0;
                init_done <= 1;
                state <= 3;
            end
            3: state <= 3;
        endcase
    end
end

endmodule