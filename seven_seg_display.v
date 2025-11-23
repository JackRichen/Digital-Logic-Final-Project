`timescale 1ns / 1ps

module seven_seg_display (
input [3:0] bcd, // 4-bit BCD input
output reg [6:0] seg // 7-segment output (active low)
);
always @(*) begin
case (bcd)
4'b0000: seg = 7'b0000001; // 0
4'b0001: seg = 7'b1001111; // 1
4'b0010: seg = 7'b0010010; // 2
default: seg = 7'b0000000; // Sets intitial value
endcase
end
endmodule
