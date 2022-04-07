`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/10 15:15:02
// Design Name: 
// Module Name: LFSR
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

module LFSR(
    input clk,
    input rst_n,
    input pb_start,
    input pb_clear,
    input pb_highscore,
    output wire [9:0] led,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    output [7: 0]segs,
    output [3: 0]ssd_ctl,
    output wire led_test,
    output wire led_test_op, 
    output [1:0] led_state
    );
 
wire clk_1;
wire [5:0]Q;

wire [511:0] key_down;
wire [8:0] last_change;
wire key_valid;
wire [3: 0]outWord;

wire [1:0] clk_scan;
wire [3:0] ssd_in;
wire rst;

wire pop_up;

wire [1:0] state;
wire [9:0] led_cont;
assign rst = ~rst_n;
wire clk_05;
wire clk_100;

wire add_score;
wire [3:0] score_now1;
wire [3:0] score_now0;
wire [3:0] p1;
wire [3:0] p0;

wire add_time_counter_en;
wire [3:0] time_count1;
wire [3:0] time_count0;

wire pb_start_d;
wire pb_clear_d;
wire pb_start_op;
wire pb_clear_op;

freqdiv U0(.clk(clk),.rst_n(rst_n),.clk_1(clk_1),.clk_100(clk_100),.clk_scan(clk_scan),
                .clk_05(clk_05));
                
random_num U1(.clk(clk_1),.rst_n(rst_n),.Q(Q));

Hamster U2(.clk(clk_l),.rst_n(rst_n),.Q(Q),.state(state),.led(led),.led_cont(led_cont));
                
KeyboardDecoder U3(.key_down(key_down),.last_change(last_change),.key_valid(key_valid),
                .PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.clk(clk),.rst(rst));

scan_ctl U4(
    .ssd_ctl(ssd_ctl), // ssd display control signal 
    .ssd_in(ssd_in), // output to ssd display
    .in0(score_now1), // 1st input
    .in1(score_now0), // 2nd input
    .in2(time_count1), // 3rd input
    .in3(time_count0),  // 4th input
    .pb_highscore(pb_highscore),
    .p1(p1),
    .p0(p0),
    .ssd_ctl_en(clk_scan), // divided clock for scan control
    .state(state)
    );
    
display U5(
    .segs(segs), // 14-segment segs output
    .bin(ssd_in)  // binary input
    );    
    
num_decoder U6(.last_change(last_change), .outWord(outWord));

show_pop_up U7(.clk(clk),.rst(rst),.led(led),.last_change(last_change),.key_down(key_down),
                .led_test(led_test),.clk_1(clk_05),.pop_up(pop_up));
 
onePulse Utest_op(.pb_d(led_test),.clk_d(clk_100),.rst_n(rst_n),.pb(led_test_op));

wire [9:0] hamster_op;

arrange_onePulse U8(.led_cont(led_cont),.clk_100(clk_100),.rst_n(rst_n),.hamster_op(hamster_op));
//onePulse Uled0(.pb_d(led_cont[0]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[0]));    
//onePulse Uled1(.pb_d(led_cont[1]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[1]));  
//onePulse Uled2(.pb_d(led_cont[2]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[2]));  
//onePulse Uled3(.pb_d(led_cont[3]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[3]));  
//onePulse Uled4(.pb_d(led_cont[4]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[4]));  
//onePulse Uled5(.pb_d(led_cont[5]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[5]));  
//onePulse Uled6(.pb_d(led_cont[6]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[6]));  
//onePulse Uled7(.pb_d(led_cont[7]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[7]));  
//onePulse Uled8(.pb_d(led_cont[8]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[8]));  
//onePulse Uled9(.pb_d(led_cont[9]),.clk_d(clk_100),.rst_n(rst_n),.pb(hamster_op[9]));  

fsm_hamster2 U9(.rst_n(rst_n),.clk(clk),.clk_100(clk_100),.hamster_op(hamster_op),
                .led_test_op(led_test_op),.state(state),.pb_start_op(pb_start_op),
                .pb_clear_op(pb_clear_op),.time_count1(time_count1),.time_count0(time_count0));

score U10(.rst_n(rst_n),.clk(clk),.hamster_op(hamster_op),.led_test_op(led_test_op),   
                .state(state),.add_score(add_score)); 

wire [3:0] score_now1_r;
wire [3:0] score_now0_r;
two_digit_up_counter U11(.clk(clk),.rst_n(rst_n),.add_score(add_score),.q1(score_now1),
                .q0(score_now0),.reset1(score_now1_r),.reset0(score_now0_r),
                .pb_clear_op(pb_clear_op));
    
record U12(.rst_n(rst_n),. clk(clk_100),. q1(score_now1),. q0(score_now0),.p1(p1),. p0(p0));

time_counter U13(.rst_n(rst_n),.clk(clk),.hamster_op(hamster_op),
                .state(state),.add_time_counter_en(add_time_counter_en));

wire [3:0] time_count1_r;
wire [3:0] time_count0_r;
two_digit_up_counter U14(.clk(clk_100),.rst_n(rst_n),.add_score(add_time_counter_en),
                .q1(time_count1),.q0(time_count0),.reset1(time_count1_r),.reset0(time_count0_r),
                .pb_clear_op(pb_clear_op));

debounce_circuit U15(
  .clk(clk), // clock control
  .rst_n(rst_n), // reset
  .pb_in(pb_start), //push button input
  .pb_debounced(pb_start_d) // debounced push button output
);

debounce_circuit U16(
  .clk(clk), // clock control
  .rst_n(rst_n), // reset
  .pb_in(pb_clear), //push button input
  .pb_debounced(pb_clear_d) // debounced push button output
);

onePulse U15op(.pb_d(pb_start_d),.clk_d(clk_100),.rst_n(rst_n),.pb(pb_start_op));    
onePulse U16op(.pb_d(pb_clear_d),.clk_d(clk_100),.rst_n(rst_n),.pb(pb_clear_op));    

count_reset U11r(.rst_n(rst_n),.clk(clk),.n1(score_now1),.n0(score_now0),.state(state),.reset1(score_now1_r),.reset0(score_now0_r));
count_reset U14r(.rst_n(rst_n),.clk(clk),.n1(time_count1),.n0(time_count0),.state(state),.reset1(time_count1_r),.reset0(time_count0_r));


assign led_state = state;
                 
endmodule