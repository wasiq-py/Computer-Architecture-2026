module switches(
    input         clk,
    input         rst,
    input  [31:0] writeData,
    input         writeEnable,
    input         readEnable,
    input  [29:0] memAddress,
    output reg [31:0] readData,
    output reg [15:0] leds
);
    always @(posedge clk) begin
        if (rst) begin
            leds     <= 0;
            readData <= 0;
        end else begin
            if (writeEnable)
                leds <= writeData[15:0];
            readData <= {16'b0, leds};
        end
    end
endmodule