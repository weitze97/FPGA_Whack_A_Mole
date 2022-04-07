`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_a 8'b01111111
`define SS_s 8'b11111101
`define SS_m 8'b11101111
`define enter 8'b11111111

module num_decoder(
    input [8: 0]last_change,
    output reg [3:0] outWord
//    output reg [7: 0]outWord
    );
    
    always@*
    begin
        case (last_change)
            //Number input will show number output in 7-seg 
            9'h016: outWord = 4'd1;
            9'h01E: outWord = 4'd2;
            9'h026: outWord = 4'd3;
            9'h025: outWord = 4'd4;
            9'h02E: outWord = 4'd5;
            9'h036: outWord = 4'd6;
            9'h03D: outWord = 4'd7;
            9'h03E: outWord = 4'd8;
            9'h046: outWord = 4'd9;
            9'h045: outWord = 4'd0;
            // The above is the content of the previous question lab8_1_1
            
            //add a, s, m function
//            9'h01C: outWord = `SS_a;
//            9'h01B: outWord = `SS_s;
//            9'h03A: outWord = `SS_m;
            
            //add enter function
//            9'h05A: outWord = `enter;
            default: outWord = 4'd15;
        endcase
    end
endmodule
