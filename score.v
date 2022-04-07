`include "global.v"

module score(rst_n, clk, hamster_op, led_test_op, state, add_score);
    input rst_n;
	input clk;
	input [9:0] hamster_op;
	input led_test_op;
	input [1:0] state;
	output reg add_score;

    reg add_score_next;

always @*
case (state)
`POP:
begin
	if (led_test_op)
		add_score_next = 1;
	else
		add_score_next = 0;
end
`HIT:
begin
	if (hamster_op != 10'd0)
		add_score_next = 0;
	else
		add_score_next = 0;
end
default:
	add_score_next = 0;
endcase
	
always @(posedge clk or negedge rst_n)
if (~rst_n)
	add_score <= 0;
else
	add_score <= add_score_next;
	
endmodule
