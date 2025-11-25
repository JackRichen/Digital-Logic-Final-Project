//`timescale 1ns / 1ps

//module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,clk_slow,Disp_1,Disp_2);
//input emerg_in, g_f,f_f,s_f,reset,clk, clk_slow;
//output reg emerg_out;
//output reg [3:0] Disp_1; // Current floor display #
//output reg [3:0] Disp_2; // Next floor display #

//reg [1:0] state;
//reg [2:0] floor_order; // Describes which floor are in queue
//parameter[1:0] GROUND=2'b00, FIRST=2'b01, SECOND=2'b10, EMERGENCY=2'b11;
//parameter[3:0] D_ZERO = 4'b0000, D_ONE=4'b0001,D_TWO=4'b0010,D_THREE=4'b0011;

//always@(posedge clk) begin //fast clk for button inputs
//    if(g_f) floor_order[0] <= 1;
//    if(f_f) floor_order[1] <= 1;
//    if(s_f) floor_order[2] <= 1;
//end


//always@(posedge clk) begin
//if (reset) begin // stops elevator where it is, untriggers all output
//    emerg_out <= 0;
//    state <= GROUND;
//    Disp_1 <= D_ZERO;//only time we need to give Disp_1 an exact value because the current floor should be updated to next floor when the elevator reaches that state
//    Disp_2 <= D_ZERO;
//end
//else if (emerg_in) begin
//    state <= EMERGENCY;
//    emerg_out <= 1;
//end
//else
//    case(state)
//        GROUND: begin
//        Disp_1 <= D_ZERO; // current floor
    
//        // Check requests for other floors only
//        if (floor_order[1]) begin
//            state <= FIRST;
//            Disp_2 <= D_ONE;
//            floor_order[1] <= 0; // clear request after moving
//        end
//        else if (floor_order[2]) begin
//            state <= SECOND;
//            Disp_2 <= D_TWO;
//            floor_order[2] <= 0;
//        end
//        else begin
//            // No requests or request for current floor
//            state <= GROUND;
//            Disp_2 <= D_ZERO;
//            // Do NOT clear floor_order[0]
//        end
//    end
    
//    FIRST: begin
//        Disp_1 <= D_ONE; // current floor
    
//        // Check requests for other floors only
//        if (floor_order[0]) begin
//            state <= GROUND;
//            Disp_2 <= D_ZERO;
//            floor_order[0] <= 0;
//        end
//        else if (floor_order[2]) begin
//            state <= SECOND;
//            Disp_2 <= D_TWO;
//            floor_order[2] <= 0;
//        end
//        else begin
//            // No requests or request for current floor
//            state <= FIRST;
//            Disp_2 <= D_ONE;
//            // Do NOT clear floor_order[1]
//        end
//    end
    
//    SECOND: begin
//        Disp_1 <= D_TWO; // current floor
    
//        // Check requests for other floors only
//        if (floor_order[0]) begin
//            state <= GROUND;
//            Disp_2 <= D_ZERO;
//            floor_order[0] <= 0;
//        end
//        else if (floor_order[1]) begin
//            state <= FIRST;
//            Disp_2 <= D_ONE;
//            floor_order[1] <= 0;
//        end
//        else begin
//            // No requests or request for current floor
//            state <= SECOND;
//            Disp_2 <= D_TWO;
//            // Do NOT clear floor_order[2]
//        end
//    end
    
//    EMERGENCY: begin // stuck in emergency until it is manually reset
//        emerg_out <= 1;
//        Disp_2 <= Disp_1; // next floor display shows current floor
//        end
//    endcase
//end
//endmodule


`timescale 1ns / 1ps
module FSM(emerg_in, g_f,f_f,s_f,emerg_out,reset,clk,Disp_1,Disp_2);
input emerg_in, g_f,f_f,s_f,reset,clk;
output reg emerg_out;
output reg [3:0] Disp_1; // Current floor display #
output reg [3:0] Disp_2; // Next floor display #

reg [1:0] state;
parameter[1:0] GROUND=2'b00, FIRST=2'b01, SECOND=2'b10, EMERGENCY=2'b11;
parameter[3:0] D_ZERO = 4'b0000, D_ONE=4'b0001,D_TWO=4'b0010,D_THREE=4'b0011;


always@(posedge clk or posedge reset) begin
if (reset) begin // stops elevator where it is, untriggers all output
    emerg_out <= 0;
    state <= GROUND;
    Disp_1 <= D_ZERO;//only time we need to give Disp_1 an exact value because the current floor should be updated to next floor when the elevator reaches that state
    Disp_2 <= D_ZERO;
end
else if (emerg_in) begin
    state <= EMERGENCY;
    emerg_out <= 1;
    Disp_1 <= 4'b0000;
    Disp_2 <= 4'b0000;
end
else
    case(state)
    GROUND: begin
        Disp_1 <= D_ZERO; // Current floor assignment
        
        if (f_f) begin
        state <= FIRST;
        Disp_2 <= D_ONE;
        end
        else if (s_f) begin
        state <= SECOND;
        Disp_2 <= D_TWO;
        end
        else begin
        state <= GROUND;
        Disp_2 <= D_ZERO;
        end
        end
        
    FIRST: begin
        Disp_1 <= D_ONE;
        if (g_f) begin
        state <= GROUND;
        Disp_2 <= D_ZERO;
        end
        else if (s_f) begin
        state <= SECOND;
        Disp_2 <= D_TWO;
        end
        else begin
        state <= FIRST;
        Disp_2 <= D_ONE;
        end
        end
        
    SECOND: begin
        Disp_1 <= D_TWO;
        if (g_f) begin
        state <= GROUND;
        Disp_2 <= D_ZERO;
        end
        else if (f_f) begin
        state <= FIRST; 
        Disp_2 <= D_ONE;
        end
        else begin
        state <= SECOND;
        Disp_2 <= D_TWO;
        end
        end
        
    EMERGENCY: begin // stuck in emergency until it is manually reset
        emerg_out <= 1;
        Disp_2 <= Disp_1; // next floor display shows current floor
        end
    endcase
end
endmodule

