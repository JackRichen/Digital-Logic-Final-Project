`timescale 1ns / 1ps

module display_multiplexing(clk,Disp_1,Disp_2, seg,an);
input clk;
input [3:0] Disp_1;
input [3:0] Disp_2;
output [6:0] seg;
output reg [7:0] an;

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

seven_seg_display ss_disp (.bcd(Disp_Current),.seg(seg));

always @(posedge clk_usable) begin
case (an)
        8'b1111_1110: begin // 2
            an <= 8'b1111_1101;
            Disp_Current <= Disp_2; // next 
        end
        8'b1111_1101: begin // 3
            an <= 8'b1111_1011;
            Disp_Current <= 4'b1111; 
        end
        8'b1111_1011: begin // 4
            an <= 8'b1111_0111;
            Disp_Current <= 4'b1111; 
        end
        8'b1111_0111: begin // 5
            an <= 8'b1110_1111;
            Disp_Current <= 4'b1111; 
        end
        8'b1110_1111: begin // 6
            an <= 8'b1101_1111;
            Disp_Current <= 4'b1111; 
        end
        8'b1101_1111: begin // 7
            an <= 8'b1011_1111;
            Disp_Current <= 4'b1111;
        end
        8'b1011_1111: begin // 8
            an <= 8'b0111_1111;
            Disp_Current <= 4'b1111; 
        end
        8'b0111_1111: begin // 1
            an <= 8'b1111_1110; 
            Disp_Current <= Disp_1; // current
        end
        default: begin // def
            an <= 8'b1111_1110; 
            Disp_Current <= 4'b1001; // shows a non-zero, non obtainable number to show an issue
        end
    endcase
end



endmodule