`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2025 06:35:24 PM
// Design Name: 
// Module Name: LED
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LED(
    input  [3:0] Disp_2,       // next floor
    input new_clock,
    output reg [2:0] next_LED
    );
    
    always@(posedge new_clock) begin
        case (Disp_2)
        4'b0000 : next_LED = 3'b001;
        4'b0001 : next_LED = 3'b010;
        4'b0010 : next_LED = 3'b100;
    endcase
end
    
    
endmodule
