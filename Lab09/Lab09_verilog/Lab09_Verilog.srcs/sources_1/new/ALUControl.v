module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
    );
    always@(*) begin
    case (ALUOp) 
    2'b00: ALUControl = 4'b0010;
    2'b01: ALUControl = 4'b0110;
    2'b10: begin
        case (funct3)
            3'b000 : begin
                case (funct7)
                    7'b0000000: begin
                        ALUControl = 4'b0010;
                    end 
                    7'b0100000: begin
                        ALUControl = 4'b0110;
                    end
                endcase
            end
            3'b111 : ALUControl = 4'b0000;
            3'b110 : ALUControl = 4'b0001;
            3'b100 : ALUControl = 4'b0011;
            3'b001 : ALUControl = 4'b0100;
            3'b101 : ALUControl = 4'b0101;
        endcase
    end
    endcase
    end
endmodule