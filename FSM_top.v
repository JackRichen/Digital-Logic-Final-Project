`timescale 1ns / 1ps

module FSM_top(emerg_in, g_f,f_f,s_f,emerg_out,motor, reset,clk,seg,next_LED, an);
input emerg_in, g_f,f_f,s_f,reset,clk;

output [6:0] seg;
output [7:0] an;

output wire emerg_out;
output wire [2:0] motor;
output wire [2:0] next_LED; // LED for next state

wire [3:0] Disp_1; // Current floor
wire [3:0] Disp_2; // Next floor

wire new_clock; // slower 1HZ clock


clock_divider d (.clk_in(clk), .reset(reset), .clk_out(new_clock));
FSM f (.emerg_in(emerg_in), .g_f(g_f),.f_f(f_f),.s_f(s_f),.emerg_out(emerg_out),.reset(reset),.clk(new_clock),.Disp_1(Disp_1),.Disp_2(Disp_2));
LED l (.Disp_2(Disp_2),.new_clock(new_clock), .next_LED(next_LED));


//disp_hex_mux(.clk(clk), .reset(reset), .hex3(4'b0000), .hex2(Disp_2), 
//.hex1(4'b0000), .hex0(Disp_1), .dp_in(4'b0101), .an(an),.sseg(sseg)); 
display_multiplexing d2 (.clk(clk),.Disp_1(Disp_1),.Disp_2(Disp_2), .seg(seg),.an(an));

motor_driver mdrv (
    .clk(clk),
    .reset(reset),
    .c_f(Disp_1[1:0]),
    .n_f(Disp_2[1:0]),
    .motor(motor)
);

endmodule
