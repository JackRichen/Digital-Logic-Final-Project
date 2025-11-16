`timescale 1ns / 1ps


module tb_FSM();
reg emerg_in, g_f,f_f,s_f,reset,clk;
wire emerg_out;
wire [3:0] Disp_1;
wire [3:0] Disp_2;

FSM uut (.emerg_in(emerg_in), .g_f(g_f),.f_f(f_f),.s_f(s_f),.emerg_out(emerg_out),.reset(reset),.clk(clk),.Disp_1(Disp_1),.Disp_2(Disp_2));
initial begin//good inputs only
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 1; clk = 1;#10;
emerg_in = 0; g_f = 1; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 1; f_f = 0; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 1; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 1; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 1; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 1; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 1; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 1; f_f = 0; s_f = 0; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 1; reset = 0; clk = 0;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 1; reset = 0; clk = 1;#10;
emerg_in = 0; g_f = 0; f_f = 0; s_f = 0; reset = 0; clk = 0;#10;
$finish;
end
endmodule
