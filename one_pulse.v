module onePulse(
    input pb_d,
    input clk_d,
    input rst_n,
    output reg pb
);
    reg pb_temp;
    reg pbI;
    reg pbI_temp;
    
    always@*
    begin
        pb_temp = ~pbI & pb_d;
        pbI_temp = pb_d;
    end
    
    
    always@(posedge clk_d or negedge rst_n)
            if (~rst_n)
            begin
                pb <= 0;
                pbI <= 0;
            end
            else
            begin
                pb <= pb_temp;
                pbI <= pbI_temp;
            end
endmodule