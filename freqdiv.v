module freqdiv(
    input clk,
    input rst_n,
    output reg clk_1,
    output reg clk_100,
    output reg [1: 0]clk_scan,
    output reg clk_05
    );

    reg [10: 0]clk_h;
    reg [12: 0]clk_l;
    reg [25: 0]cnt_50M_temp;
    reg [19: 0]cnt_50W;
    reg [19: 0]cnt_50W_temp;
    reg clk_100_temp;
    reg clk_1_temp;
    
    reg [25: 0]cnt_25M_temp;
    reg [25: 0]cnt_25M;
    reg clk_05_temp;
    
    always@*
    begin
        if ({clk_h, clk_scan, clk_l} == 26'd50_000_000)
        begin
            cnt_50M_temp = 26'b0;
            clk_1_temp = (~clk_1);
        end
        else
        begin
            cnt_50M_temp = {clk_h, clk_scan, clk_l} + 1;
            clk_1_temp = clk_1;
        end
        
        if (cnt_50W == 19'd500_000)
                begin
                    cnt_50W_temp = 13'b0;
                    clk_100_temp = (~clk_100);
                end
                else
                begin
                    cnt_50W_temp = cnt_50W + 1;
                    clk_100_temp = clk_100;
                end
                
        if (cnt_25M == 25'd25_000_000)
                begin
                    cnt_25M_temp = 25'b0;
                    clk_05_temp = (~clk_05);
                end
                else
                begin
                    cnt_25M_temp = cnt_25M + 1;
                    clk_05_temp = clk_05;
                end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if (~rst_n)
        begin
            {clk_h, clk_scan, clk_l} <= 26'b0;
            clk_1 <= 0;
            cnt_50W <= 0;
            clk_100 <= 0;
            cnt_25M <= 0;
            clk_05 <= 0;
        end
        else
        begin
            {clk_h, clk_scan, clk_l} <= cnt_50M_temp;
            clk_1 <= clk_1_temp;
            cnt_50W <= cnt_50W_temp;
            clk_100 <= clk_100_temp;
            cnt_25M <= cnt_25M_temp;
            clk_05 <= clk_05_temp;
        end
    end
endmodule