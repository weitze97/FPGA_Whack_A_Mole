`include "global.v"

module fsm_hamster2(rst_n, clk, clk_100, hamster_op, led_test_op, state, pb_start_op, pb_clear_op, 
                    time_count1, time_count0);
    input rst_n;
	input clk;
	input clk_100;
	input [9:0] hamster_op;
	input led_test_op;
	input [3:0]time_count1;
	input [3:0]time_count0;
	output reg [1:0] state; //redefined

//new-defined
	input pb_start_op;
	input pb_clear_op;
	
 	reg [1:0] state_next; //redefined
	
always @*
case (state)
//new-defined
`HOLD:
begin
	if (pb_start_op==1'b1)
		state_next = `POP;
	else
		state_next = `HOLD;
end
//
`POP:
begin
	if (led_test_op)
		state_next = `HIT;
	else
		if(time_count1==4'd2 && time_count0==4'd1)
		  state_next = `STOP;
		else
		  state_next = `POP;
end
`HIT:
begin
	if (hamster_op != 10'd0)
		state_next = `POP;
	else
		state_next = `HIT;
end
//new-defined
`STOP:
begin
	if (pb_clear_op==1)
		state_next = `HOLD;
	else
		state_next = `STOP;
end
//
default:
	state_next = state;
endcase
	
always @(posedge clk or negedge rst_n)
if (~rst_n)
	state <= `HOLD;
else
	state <= state_next;
	
endmodule
	
