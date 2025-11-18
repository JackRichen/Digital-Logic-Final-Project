`timescale 1ns / 1ps

module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,Disp_1,Disp_2);
    input emerg_in, g_f,f_f,s_f,reset,clk;
    output reg emerg_out;
    output reg [3:0] Disp_1;
    output reg [3:0] Disp_2;
    
    reg [1:0] state;

    parameter[1:0] GROUND=2'b00, FIRST=2'b01, SECOND=2'b10, EMERGENCY=2'b11;
    parameter[3:0] D_ZERO = 4'b0000, D_ONE=4'b0001,D_TWO=4'b0010,D_THREE=4'b0011;

    always@(posedge reset or posedge clk) begin
    
    
    if (reset) begin // stops elevator where it is, untriggers all output
            emerg_out <= 0;
            state = GROUND;
            Disp_1 <= D_ZERO;//only time we need to give Disp_1 an exact value because the current floor should be updated to next floor when the elevator reaches that state
            Disp_2 <= D_ZERO;
        end
    else if (emerg_in) begin
            state     <= EMERGENCY;
            emerg_out <= 1;
        end        
    else 
        case(state)
            GROUND: begin
                Disp_1 <= D_ZERO;
                if (f_f) begin
                    state  <= FIRST;
                    Disp_2 <= D_ONE;
                end
                else if (s_f) begin
                    state  <= SECOND;
                    Disp_2 <= D_TWO;
                end
                else begin
                    state  <= GROUND;
                    Disp_2 <= D_ZERO;
                end
            end

            FIRST: begin
                Disp_1 <= D_ONE;
                if (g_f) begin
                    state  <= GROUND;
                    Disp_2 <= D_ZERO;
                end
                else if (s_f) begin
                    state  <= SECOND;
                    Disp_2 <= D_TWO;
                end
                else begin
                    state  <= FIRST;
                    Disp_2 <= D_ONE;
                end
            end

            SECOND: begin
                Disp_1 <= D_TWO;
                if (g_f) begin
                    state  <= GROUND;
                    Disp_2 <= D_ZERO;
                end
                else if (f_f) begin
                    state  <= FIRST;
                    Disp_2 <= D_ONE;
                end
                else begin
                    state  <= SECOND;
                    Disp_2 <= D_TWO;
                end
            end
            EMERGENCY: begin // stuck in emergency until it is manually reset
                emerg_out <= 1;
                    Disp_2 <= Disp_1;  // next floor display shows current floor
                    Disp_1 <= Disp_1;  //if no input current floor and next floor should be the same
            end
        endcase
    end
endmodule

        
//    begin
//        if(reset)
//        begin
//            emerg_out <= 0;
//            Disp_1 <= 4'b0000;//only time we need to give Disp_1 an exact value because the current floor should be updated to next floor when the elevator reaches that state
//            Disp_2 <= 4'b0000;
//        end
//        else
//            begin
//            if(emerg_in || emerg_out)
//                begin
//                emerg_out <= 1;//cannot leave emergency state unless reset
//                Disp_2 <= Disp_1; //hold floor if emergency is on
//                end
            
//            else if (g_f)
//                begin
//                Disp_2 <= 4'b0000;
//                Disp_1 = Disp_2;
//                end
//            else if(f_f)
//                begin
//                Disp_2 <= 4'b0001;
//                Disp_1 = Disp_2;
//                end
//             else if(s_f)
//                begin
//                Disp_2 <= 4'b0010;
//                Disp_1 = Disp_2;
//                end
//             else
//                begin
//                Disp_2 = Disp_1;//if no input current floor and next floor should be the same
//                end
//       end
