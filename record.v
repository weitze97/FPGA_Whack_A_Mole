module record(rst_n, clk, q1, q0, p1, p0);
    input rst_n;
	input clk;
	input [3:0] q1;
	input [3:0] q0;
	output reg [3:0]p1;
	output reg [3:0]p0;

    reg [3: 0]p_temp1;
    reg [3: 0]p_temp0;
    
always@*
begin
if(q1 > p1)
begin
    p_temp1 = q1;
    p_temp0 = q0;
end
else if(q1 == p1)
begin
if(q0 > p0)
    begin
        p_temp1 = q1;
        p_temp0 = q0;
    end
else
    begin
        p_temp1 = p1;
        p_temp0 = p0;
    end  
end
else    
begin
    p_temp1 = p1;
    p_temp0 = p0;
end
end   
    
always @ (posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        p0 <= 4'b0000;
        p1 <= 4'b0000;
    end
    else
    begin
        p0 <= p_temp0;
        p1 <= p_temp1;
    end
endmodule