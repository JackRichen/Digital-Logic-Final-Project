`timescale 1ns / 1ps

module FSM_top(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,seg,next_LED,an);
input emerg_in, g_f,f_f,s_f,reset,clk;
output reg emerg_out;
output [6:0] seg;
wire [3:0] Disp_1;
wire [3:0] Disp_2;
output reg [2:0] next_LED;
output [1:0] an;
wire new_clock;
clock_divider d (.clk_in(clk), .reset(reset), .clk_out(new_clock));
FSM f (.emerg_in(emerg_in), .g_f(g_f),.f_f(f_f),.s_f(s_f),.emerg_out(emerge_out),.reset(reset),.clk(new_clock),.Disp_1(Disp_1),.Disp_2(Disp_2));

always@(posedge new_clock) begin
case (Disp_2)
    4'b0000 : next_LED = 3'b001;
    4'b0001 : next_LED = 3'b010;
    4'b0010 : next_LED = 3'b100;
endcase
end
display_multiplexing d2 (.clk(clk),.Disp_1(Disp_1),.Disp_2(Disp_2), .seg(seg),.an(an));


endmodule
