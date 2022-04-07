`timescale 1ns / 1ps
`include "global.v"
module scan_ctl(
  ssd_ctl, // ssd display control signal 
  ssd_in, // output to ssd display
  in0, // 1st input
  in1, // 2nd input
  in2, // 3rd input
  in3,  // 4th input
  ssd_ctl_en, // divided clock for scan control
  pb_highscore,
  p1,
  p0,
  state
);

output [`BCD_BIT_WIDTH-1:0] ssd_in; // Binary data 
output [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display
input [`BCD_BIT_WIDTH-1:0] in0,in1,in2,in3; // binary input control for the four digits 
input [`SSD_SCAN_CTL_BIT_WIDTH-1:0] ssd_ctl_en; // divided clock for scan control

input pb_highscore;
input [3:0] p1;
input [3:0] p0;
input [1:0] state;
reg [`SSD_NUM-1:0] ssd_ctl; // scan control for 7-segment display (in the always block)
reg [`BCD_BIT_WIDTH-1:0] ssd_in; // 7 segment display control (in the always block)

always @*
  case (ssd_ctl_en)
    2'b00: 
    begin
      ssd_ctl=4'b0111;
      ssd_in=in0;
    end
    2'b01: 
    begin
      ssd_ctl=4'b1011;
      ssd_in=in1;
    end
    2'b10:
    begin
      if (pb_highscore)
      begin
        ssd_in=p1;
        ssd_ctl=4'b1101;
      end
      else if (state == `STOP)
      begin
        ssd_in=p1;
        ssd_ctl=4'b1111;
      end
      else
      begin
        ssd_in=in2;
        ssd_ctl=4'b1101;
      end  
    end
    2'b11: 
    begin
      if (pb_highscore)
      begin
        ssd_in=p0;
        ssd_ctl=4'b1110;
      end
      else if (state == `STOP)
      begin
        ssd_in=p0;
        ssd_ctl=4'b1111;
      end
      else
      begin
        ssd_in=in3;
        ssd_ctl=4'b1110;
      end  
    end
  endcase

endmodule
