`timescale 1ns / 1ps

module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,Disp_1,Disp_2);
input emerg_in, g_f,f_f,s_f,reset,clk;
output reg emerg_out;
output reg [3:0] Disp_1;
output reg [3:0] Disp_2;

always@(posedge clk)//only clk driven now
begin
    if(reset)
    begin
        emerg_out <= 0;
        Disp_1 <= 4'b0000;
        Disp_2 <= 4'b0000;
    end
    else
        begin
        if(emerg_in || emerg_out)
            begin
            emerg_out <= 1;
            Disp_2 <= Disp_1; 
            end
        
        else if (g_f && ~f_f && ~s_f)//prevents user from pushing multiple buttons at once
            begin
            Disp_2 <= 4'b0000;
            Disp_1 = Disp_2;
            end
        else if(~g_f && f_f && ~s_f)
            begin
            Disp_2 <= 4'b0001;
            Disp_1 = Disp_2;
            end
         else if(~g_f && ~f_f && s_f)
            begin
            Disp_2 <= 4'b0010;
            Disp_1 = Disp_2;
            end
         else
            begin
            Disp_1 = Disp_2;//if no input or two floor buttons are pressed at once elevator does not move
            end
   end
end
endmodule
