module AddressDecoder(input [9:0] address, input readEnable, input writeEnable, output DataMemWrite, output DataMemRead, output LEDWrite, output SwitchReadEnable);
    assign DataMemWrite     = (address[9] == 1'b0)    && writeEnable;
    assign DataMemRead      = (address[9] == 1'b0)    && readEnable;
    assign LEDWrite         = (address[9:8] == 2'b10) && writeEnable;
    assign SwitchReadEnable = (address[9:8] == 2'b11) && readEnable;
endmodule