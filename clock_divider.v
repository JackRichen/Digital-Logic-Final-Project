`timescale 1ns / 1ps

module clock_divider #(parameter DIVISOR = 50000000) ( // for 100MHz ? 1Hz
input clk_in,
input reset,
output reg clk_out
);
reg [31:0] counter = 0;
always @(posedge clk_in or posedge reset) begin
    if (reset) begin
        counter <= 0;
        clk_out <= 0;
    end else begin
        if (counter == (DIVISOR - 1)) begin
        counter <= 0;
        clk_out <= ~clk_out; // Toggle output
    end else
        counter <= counter + 1;
    end
end
endmodule
