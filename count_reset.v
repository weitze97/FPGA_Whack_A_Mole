`include "global.v"

module count_reset(rst_n, clk, n1, n0, state, reset1, reset0);
    input rst_n;
	input clk;
	input [3:0] n1;
	input [3:0] n0;
	input [1:0] state;
	output reg [3:0]reset1;
	output reg [3:0]reset0;

    reg [3:0]reset1_next;
    reg [3:0]reset0_next;
    
always @*
case(state)
`HOLD:
begin
	reset1_next = 4'd0;
	reset0_next = 4'd0;
end
default:
begin
    reset1_next = n1;
	reset0_next = n0;
end
endcase

always @(posedge clk or negedge rst_n)
if (~rst_n)
begin
	reset1 <= 4'd0;
	reset0 <= 4'd0;
end
else
begin
	reset1 <= reset1_next;
	reset0 <= reset0_next;	
end

endmodule
