`include "global.v"

module Hamster(
    input clk,
    input rst_n,
    input [5:0] Q,
    input [1:0] state,
    output reg [9:0] led,
    output [9:0] led_cont //led_control
    );
//from 0001 to 1010                                                        
    assign led_cont[0]  = (~Q[3]) & (~Q[2]) & (~Q[1]) & ( Q[0]); //0001                
    assign led_cont[1]  = (~Q[3]) & (~Q[2]) & ( Q[1]) & (~Q[0]); //0010                
    assign led_cont[2]  = (~Q[3]) & (~Q[2]) & ( Q[1]) & ( Q[0]); //0011                
    assign led_cont[3]  = (~Q[3]) & ( Q[2]) & (~Q[1]) & (~Q[0]); //0100                
    assign led_cont[4]  = (~Q[3]) & ( Q[2]) & (~Q[1]) & ( Q[0]); //0101                
    assign led_cont[5]  = (~Q[3]) & ( Q[2]) & ( Q[1]) & (~Q[0]); //0110                
    assign led_cont[6]  = (~Q[3]) & ( Q[2]) & ( Q[1]) & ( Q[0]); //0111                
    assign led_cont[7]  = ( Q[3]) & (~Q[2]) & (~Q[1]) & (~Q[0]); //1000                
    assign led_cont[8]  = ( Q[3]) & (~Q[2]) & (~Q[1]) & ( Q[0]); //1001                
    assign led_cont[9]  = ( Q[3]) & (~Q[2]) & ( Q[1]) & (~Q[0]); //1010                
//assign led[10] = (~Q[4]) & ( Q[3]) & (~Q[2]) & ( Q[1]) & ( Q[0]); //01011
//assign led[11] = (~Q[4]) & ( Q[3]) & ( Q[2]) & (~Q[1]) & (~Q[0]); //01100
//assign led[12] = (~Q[4]) & ( Q[3]) & ( Q[2]) & (~Q[1]) & ( Q[0]); //01101
//assign led[13] = (~Q[4]) & ( Q[3]) & ( Q[2]) & ( Q[1]) & (~Q[0]); //01110
//assign led[14] = (~Q[4]) & ( Q[3]) & ( Q[2]) & ( Q[1]) & ( Q[0]); //01111
//assign led[15] = ( Q[4]) & (~Q[3]) & (~Q[2]) & (~Q[1]) & (~Q[0]); //10000

always @*
case (state)
`POP:
begin
    led = led_cont;
end
`HIT:
    led = 10'd0;
default:
    led = 10'b1111111111;
endcase
    
endmodule
