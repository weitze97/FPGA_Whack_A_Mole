`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 13:31:10
// Design Name: 
// Module Name: show_pop_up
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


module show_pop_up(
    input clk,
    input rst,
    input [9:0] led,
    input [8:0] last_change,
    input [511:0]key_down,
    output reg led_test,
    input clk_1,
    output pop_up  
    );

reg led_test_tmp;

always @*
if (led[9]==1 && last_change==9'h016 && key_down[9'h016]==1'b1)
    led_test_tmp = 1'b1;
else if(led[8]==1 && last_change==9'h01E && key_down[9'h01E]==1'b1)
    led_test_tmp = 1'b1;
else if(led[7]==1 && last_change==9'h026 && key_down[9'h026]==1'b1)
    led_test_tmp = 1'b1;
else if(led[6]==1 && last_change==9'h025 && key_down[9'h025]==1'b1)
    led_test_tmp = 1'b1;
else if(led[5]==1 && last_change==9'h02E && key_down[9'h02E]==1'b1)
    led_test_tmp = 1'b1;
else if(led[4]==1 && last_change==9'h036 && key_down[9'h036]==1'b1)
    led_test_tmp = 1'b1;
else if(led[3]==1 && last_change==9'h03D && key_down[9'h03D]==1'b1)
    led_test_tmp = 1'b1;
else if(led[2]==1 && last_change==9'h03E && key_down[9'h03E]==1'b1)
    led_test_tmp = 1'b1;
else if(led[1]==1 && last_change==9'h046 && key_down[9'h046]==1'b1)
    led_test_tmp = 1'b1;           
else if(led[0]==1 && last_change==9'h045 && key_down[9'h045]==1'b1)
    led_test_tmp = 1'b1;
else
    led_test_tmp = 1'b0;
    
always @(posedge clk or posedge rst)
if (rst)
    led_test <= 1'b0;
else
    led_test <= led_test_tmp; 
    
endmodule
