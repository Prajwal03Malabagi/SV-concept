module mod(clk,rst,din,load,mode,count);
	input clk,rst,load,mode;
	input [3:0]din;
	output reg [3:0] count;

	always@(posedge clk)
		begin
			if(rst)
				count<=0;
			else if(load)
				count<=din;
			else begin
				if(mode)begin
					if(count==12)
						count<=0;
					else
						count<=count+1;
				end
				else begin
					if(count==0)
						count<=12;
					else
						count<=count-1;
				end
				end
		end
endmodule
