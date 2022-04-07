`timescale 1ns / 1ps
`define CNT_BIT_WIDTH 4
module bin_up_cnt(
    q, //output number
    clk, //triggering clock
    rst_n, //active low reset
    cin, //carry in
    cout, //carry out
    limit,
    init_value,
    pb_clear_op
    );
    
output [`CNT_BIT_WIDTH-1:0] q; //output
output cout;
input clk; //global clock
input rst_n;
input cin;
input [3:0] limit;
input [3:0] init_value;
input pb_clear_op;

reg [`CNT_BIT_WIDTH-1:0] q; //output (in always block)
reg [`CNT_BIT_WIDTH-1:0] q_tmp;

//Combinational logics
always @*
    if(pb_clear_op == 1'b1)
        q_tmp = init_value;
    else if((cin==1'b1)&&(q==limit))
        q_tmp = 4'd0;
    else if((cin==1'b1)&&(q!=limit))
        q_tmp = q+1'b1;
    else
        q_tmp = q;

//Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
    if (~rst_n) 
        q<=`CNT_BIT_WIDTH'd0;
    else  
        q<=q_tmp;

assign cout = (cin==1'b1)&&(q==limit);
endmodule
