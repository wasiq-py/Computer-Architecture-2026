module switches(
    input clk,
    input rst,
    input [15:0] btns,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [29:0] memAddress,
    input [15:0] switches,
    output reg [31:0] readData
);
    always @(posedge clk) begin
        if (rst)
            readData <= 0;
        else if (readEnable)
            readData <= {16'b0, switches};
        else
            readData <= readData;
    end
endmodule

