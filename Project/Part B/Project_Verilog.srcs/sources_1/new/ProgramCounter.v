module ProgramCounter(
input clk,
input rst,
input [31:0] nextPC,
output reg [31:0] PC
);
always @(posedge clk or posedge rst) begin
if (rst)
PC <= 32'd0;
else
PC <= nextPC;
end
endmodule
