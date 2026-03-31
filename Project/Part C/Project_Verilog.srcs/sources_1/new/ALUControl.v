module ALUControl(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
    );
    always@(*) begin
    case (ALUOp) 
    2'b00: ALUControl = 4'b0000; // Load/Store: ADD for address calc
    2'b01: ALUControl = 4'b0001; // Branch: SUB for comparison
    2'b10: begin
        case (funct3)
            3'b000 : begin
                case (funct7)
                    7'b0000000: ALUControl = 4'b0000; // ADD
                    7'b0100000: ALUControl = 4'b0001; // SUB
                    default:    ALUControl = 4'b0000;
                endcase
            end
            3'b111 : ALUControl = 4'b0010; // AND
            3'b110 : ALUControl = 4'b0011; // OR
            3'b100 : ALUControl = 4'b0100; // XOR
            3'b001 : ALUControl = 4'b0101; // SLL
            3'b101 : ALUControl = 4'b0110; // SRL
            3'b010 : ALUControl = 4'b0111; // SLT (NEW)
            default: ALUControl = 4'b0000;
        endcase
    end
    default: ALUControl = 4'b0000;
    endcase
    end
endmodule
