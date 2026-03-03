module RF_ALU_FSM(
    input clk,
    input rst,
    input [31:0] ALUResult,
    input Zero,
    output reg WriteEnable,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] WriteData,
    output reg [3:0] ALUControl,
    output reg [4:0] state
);

always @(posedge clk) begin
    if (rst) begin
        state <= 0;
        WriteEnable <= 0;
        rs1 <= 0;
        rs2 <= 0;
        rd <= 0;
        WriteData <= 0;
        ALUControl <= 0;
    end
    else begin
        case (state)

        0: begin
            WriteEnable <= 1;
            rd <= 5'd1;
            WriteData <= 32'h10101010;
            state <= 1;
        end

        1: begin
            WriteEnable <= 1;
            rd <= 5'd2;
            WriteData <= 32'h01010101;
            state <= 2;
        end

        2: begin
            WriteEnable <= 1;
            rd <= 5'd3;
            WriteData <= 32'h00000005;
            state <= 3;
        end

        3: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd2;
            ALUControl <= 4'b0000;
            state <= 4;
        end

        4: begin
            WriteEnable <= 1;
            rd <= 5'd4;
            WriteData <= ALUResult;
            state <= 5;
        end

        5: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd2;
            ALUControl <= 4'b0001;
            state <= 6;
        end

        6: begin
            WriteEnable <= 1;
            rd <= 5'd5;
            WriteData <= ALUResult;
            state <= 7;
        end

        7: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd2;
            ALUControl <= 4'b0010;
            state <= 8;
        end

        8: begin
            WriteEnable <= 1;
            rd <= 5'd6;
            WriteData <= ALUResult;
            state <= 9;
        end

        9: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd2;
            ALUControl <= 4'b0011;
            state <= 10;
        end

        10: begin
            WriteEnable <= 1;
            rd <= 5'd7;
            WriteData <= ALUResult;
            state <= 11;
        end

        11: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd2;
            ALUControl <= 4'b0100;
            state <= 12;
        end

        12: begin
            WriteEnable <= 1;
            rd <= 5'd8;
            WriteData <= ALUResult;
            state <= 13;
        end

        13: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd3;
            ALUControl <= 4'b0101;
            state <= 14;
        end

        14: begin
            WriteEnable <= 1;
            rd <= 5'd9;
            WriteData <= ALUResult;
            state <= 15;
        end

        15: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd3;
            ALUControl <= 4'b0110;
            state <= 16;
        end

        16: begin
            WriteEnable <= 1;
            rd <= 5'd10;
            WriteData <= ALUResult;
            state <= 17;
        end

        17: begin
            WriteEnable <= 0;
            rs1 <= 5'd1;
            rs2 <= 5'd1;
            ALUControl <= 4'b0001;
            state <= 18;
        end

        18: begin
            WriteEnable <= 1;
            rd <= 5'd11;
            WriteData <= (Zero ? 32'h1 : 32'h0);
            state <= 19;
        end

        19: begin
            WriteEnable <= 1;
            rd <= 5'd12;
            WriteData <= 32'hCAFEBABE;
            state <= 20;
        end

        20: begin
            WriteEnable <= 0;
            rs1 <= 5'd12;
            rs2 <= 5'd0;
            state <= 21;
        end

        21: begin
            WriteEnable <= 0;
            state <= 21;
        end

        endcase
    end
end

endmodule