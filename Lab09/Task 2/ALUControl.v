module ALUControl(input [1:0] ALUOp, input [2:0] funct3, input [6:0] funct7, output reg [3:0] ALUControl);

always @(*) begin
    ALUControl = 4'b0000;

    case (ALUOp)
        2'b00: begin
            //instr that have imm
            ALUControl = 4'b0000;
        end

        2'b01: begin
            //beq
            ALUControl = 4'b0001;
        end

        2'b10: begin
            //r type
            case (funct3)
                3'b000: begin
                    if (funct7 == 7'b0100000)
                        ALUControl = 4'b0001; //sun
                    else
                        ALUControl = 4'b0000; //add
                end
                3'b001: ALUControl = 4'b0010; //sll
                3'b101: ALUControl = 4'b0011; //srl
                3'b111: ALUControl = 4'b0100; //and
                3'b110: ALUControl = 4'b0101; //or
                3'b100: ALUControl = 4'b0110; //xor
                default: ALUControl = 4'b0000;
            endcase
        end

        default: begin
            ALUControl = 4'b0000;
        end
    endcase
end

endmodule