`timescale 1ns / 1ps

module display_multiplexing(clk,Disp_1,Disp_2, seg,an);
input clk;
input [3:0] Disp_1;
input [3:0] Disp_2;
output [6:0] seg;
output reg [1:0] an;

reg clk_usable;

parameter DIVISOR = 50000; 
reg [16:0] count = 0;

    always @(posedge clk) 
    begin
        if (count == DIVISOR - 1)
        begin
            count <= 0;
            clk_usable <= ~clk_usable;
        end 
        
        else 
        begin
            count <= count + 1;
        end
    end
    
reg [3:0] Disp_Current;

seven_seg_display(.bcd(Disp_Current),.seg(seg));

always @(posedge clk_usable) begin
        if (an[0] == 2'b01) 
        begin 
            an <= 2'b10;
            Disp_Current <= Disp_1;
        end
        else 
        begin
            an <= 2'b01;
            Disp_Current <= Disp_2;
        end
    end
endmodule
