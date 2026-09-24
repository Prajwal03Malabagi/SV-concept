module mod;
	string st;
	reg rg;
	wire w;
	byte by;
	time t;
	bit b;
	int i;
	real r;
	logic l;
	
	initial begin
	$display("string default value is =%0s",st);
	$display("reg default value is =%0b",rg);
	$display("wire default value is =%0b",w);
	$display("bite default value is =%b",b);
	$display("time default value is =%0t",t);
	$display("byte default value is =%b",by);
	$display("real default value is =%f",r);	
	$display("logic default value is =%0d",l);
	end
endmodule
