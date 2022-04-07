module two_digit_up_counter(
    clk,
    rst_n,
    add_score, //when it's 1, it will let score add 1
    q1,
    q0,
    reset1,
    reset0,
    pb_clear_op
    );
    input clk;
    input rst_n;
    input add_score;
    input [3:0] reset1;
    input [3:0] reset0;
    input pb_clear_op;
    output [3:0] q1;
    output [3:0] q0;
    wire c0;
   
bin_up_cnt U0(
    .q(q0), //output number
    .clk(clk), //triggering clock
    .rst_n(rst_n), //active low reset
    .cin(add_score), //carry in
    .cout(c0), //carry out
    .limit(4'd9),
    .init_value(reset0),
    .pb_clear_op(pb_clear_op)
    );    
    
bin_up_cnt U1(
    .q(q1), //output number
    .clk(clk), //triggering clock
    .rst_n(rst_n), //active low reset
    .cin(c0), //carry in
    .cout(), //carry out
    .limit(4'd9),
    .init_value(reset1),
    .pb_clear_op(pb_clear_op)
    ); 
endmodule
