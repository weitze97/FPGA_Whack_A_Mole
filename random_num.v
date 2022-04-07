`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/10 15:25:42
// Design Name: 
// Module Name: random_num
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


module random_num(
    input clk,
    input rst_n,
    output reg [5:0] Q 
    );

reg [5:0] Q_tmp;

always @*
begin
    Q_tmp[5] = Q[4]^Q[2]^Q[1]^Q[0];
    Q_tmp [4:0] = {Q[5], Q[4], Q[3], Q[2], Q[1]};
end

always @(posedge clk or negedge rst_n)
if (~rst_n)     
    Q <= 6'b11111;
else
    Q <= Q_tmp;
    
endmodule
