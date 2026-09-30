/*
module mod;
bit a=1;
bit b=0;
initial begin
	a<=b;
	b<=a;
end
initial $monitor("a=%0d,b=%0d",a,b);
endmodule
*/
/*
module mod;
int a=4'b1010;
int b=4'b0101;
int y;
assign y=a&b;
initial $display("y=%0b",y);
endmodule
*/

/*
module mod;
	int q[$]={5,10,15};
	initial begin
		q.push_front(3);
		q.push_back(1);
		void'(q.pop_front());
		$display("%0d",q[0]);
	end
endmodule
*/
/*

module mod;
bit signed [3:0]a;
bit signed [4:0]b;

initial begin
	a=1101;
	b=a;
	$display("%0b a=%0d",b,a);
end
endmodule
*/

module mod(clk,d,rst,q,q1);
input clk,d,rst;
output reg q,q1;

	always @(posedge clk or negedge rst)
		begin
			if(!rst)begin
				q=0;
			//	q1<=0;
			end
			else
			begin
				q=d;	
			//	q1<=d;
			end
		end
		always @(posedge clk or negedge rst)
		begin
			if(!rst)begin
			//	q<=0;
				q1=0;
			end
			else
			begin
			//	q<=d;	
				q1=d;
			end
		end

endmodule

module mod_tb;
reg clk,d,rst;
wire q,q1;

mod dut(clk,d,rst,q,q1);

always #5 clk=~clk;
initial begin
	rst=0;
	clk=0;
	d=0;
	#10;
	rst=1;
	d=1;
	#10;
	d=0;
	#10;
	d=1;
	#10 $finish();
end

initial $monitor($time,"rst=%0d,d=%0d,q=%0d,q1=%0d",rst,d,q,q1);
endmodule
