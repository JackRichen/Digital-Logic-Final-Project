`timescale 1ns / 1ps

module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,Disp_1,Disp_2);
input emerg_in, g_f,f_f,s_f,reset,clk;
output reg emerg_out;
output reg [3:0] Disp_1;
output reg [3:0] Disp_2;

    always@(posedge reset or posedge clk)//not sure if reset should be included or not
begin
    if(reset)
    begin
        emerg_out <= 0;
        Disp_1 <= 4'b0000;//only time we need to give Disp_1 an exact value because the current floor should be updated to next floor when the elevator reaches that state
        Disp_2 <= 4'b0000;
    end
    else
        begin
        if(emerg_in || emerg_out)
            begin
            emerg_out <= 1;//cannot leave emergency state unless reset
            Disp_2 <= Disp_1; //hold floor if emergency is on
            end
        
        else if (g_f)
            begin
            Disp_2 <= 4'b0000;
            Disp_1 = Disp_2;
            end
        else if(f_f)
            begin
            Disp_2 <= 4'b0001;
            Disp_1 = Disp_2;
            end
         else if(s_f)
            begin
            Disp_2 <= 4'b0010;
            Disp_1 = Disp_2;
            end
         else
            begin
            Disp_2 = Disp_1;//if no input current floor and next floor should be the same
            end
   end
end
endmodule
