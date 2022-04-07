`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/12 04:59:27
// Design Name: 
// Module Name: arrange_onePulse
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


module arrange_onePulse(
    input [9:0] led_cont,
    input clk_100,
    input rst_n,
    output [9:0]hamster_op
);





onePulse Uled0(.pb_d(led_cont[0]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[0]));    
onePulse Uled1(.pb_d(led_cont[1]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[1]));  
onePulse Uled2(.pb_d(led_cont[2]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[2]));  
onePulse Uled3(.pb_d(led_cont[3]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[3]));  
onePulse Uled4(.pb_d(led_cont[4]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[4]));  
onePulse Uled5(.pb_d(led_cont[5]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[5]));  
onePulse Uled6(.pb_d(led_cont[6]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[6]));  
onePulse Uled7(.pb_d(led_cont[7]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[7]));  
onePulse Uled8(.pb_d(led_cont[8]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[8]));  
onePulse Uled9(.pb_d(led_cont[9]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[9])); 
    
endmodule
