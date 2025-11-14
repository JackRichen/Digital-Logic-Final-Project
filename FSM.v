`timescale 1ns / 1ps

module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,Disp_1,Disp_2);
input emerg_in, g_f,f_f,s_f,reset,clk;
output reg emerg_out;
//output reg [3:0] c_state;
output reg [3:0] Disp_1;
output reg [3:0] Disp_2;

always@(posedge reset or posedge clk)
begin
    if(reset)
    begin
        //c_state <= 4'b0000;
        //n_f <= 4'b0000;
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
        
        else if (g_f)
            begin
            Disp_2 <= 4'b0000;
            //c_state = Disp_2;
            Disp_1 = Disp_2;
            //c_state = Disp_2;
            end
        else if(f_f)
            begin
            Disp_2 <= 4'b0001;
            Disp_1 = Disp_2;
            //c_state = Disp_2;
            end
         else if(s_f)
            begin
            Disp_2 <= 4'b0010;
            // c_state = Disp_2;
            Disp_1 = Disp_2;
            //c_state = Disp_2;
            end
         else
            begin
            Disp_2 = Disp_1;
            end
   end
end
endmodule
