`include "global.v"

module time_counter(rst_n, clk, hamster_op, state, add_time_counter_en);
    input rst_n;
	input clk;
	input [9:0] hamster_op;
	input [1:0] state;
	output reg add_time_counter_en;
    reg add_time_counter_en_next;


always @*
case(state)
`POP:
begin
	if (hamster_op != 10'd0)
		add_time_counter_en_next = 1;
	else
		add_time_counter_en_next = 0;
end
default:
    add_time_counter_en_next = 0;
endcase
	
always @(posedge clk or negedge rst_n)
if (~rst_n)
	add_time_counter_en <= 0;
else
	add_time_counter_en <= add_time_counter_en_next;
	
endmodule


