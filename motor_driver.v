
`timescale 1ns / 1ps
// Code modified by example provided by 
// Aleksandar Haber: https://youtu.be/Krp4uEbOFq4?t=727


module motor_driver(
    input clk,          // fast clock (100MHz)
    input reset,
    input [1:0] c_f, // current floor
    input [1:0] n_f, // next floor
    output [2:0] motor
);
    reg [2:0] control; //control signal for motor pins // ENA, IN3, IN4
    
    integer periodLength = 1000000; // size of clk pulse
    integer fastPulse = 700000; // desired size of single PWM cycle
    integer slowPulse = 400000;
    
    integer pulseLength = 0; // actual pulselength
    
    integer counter = 0;

    
    always@(posedge clk) begin
//        if(n_f == c_f) // counter stuck at 0 until it's needed for PWM signal.
//             counter <= 0;
        if(counter<periodLength) 
            counter <= counter + 1;
        else
            counter <= 0;
        
        case({c_f, n_f})  //control[2] = 0 -> slow, control[2] = 1 -> fast (for 1 -> 3)
    //            4'b0000: control <= 3'b000;
            4'b0001: control <= 3'b001;
            4'b0010: control <= 3'b101;
            4'b0100: control <= 3'b010;
    //            4'b0101: control <= 3'b000;
            4'b0110: control <= 3'b001;            
            4'b1000: control <= 3'b110;
            4'b1001: control <= 3'b010;
    //            4'b1010: control <= 3'b000;
            default: control <= 3'b000; // off
         endcase
     
         pulseLength = (control[2])? fastPulse : slowPulse;
         
    end
    
    assign motor[0] = control[0];
    assign motor[1] = control[1];
    assign motor[2] = (pulseLength>counter)? 1'b1: 1'b0;

endmodule
