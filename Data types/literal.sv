module mod;
	reg [31:0]a;
	logic [31:0]b;
	
	initial begin
		a='1;//all 32-bit are 1 means '1 is all 1's
		b='1;
		$display("a=%b,b=%b",a,b);
		a=32'b1;//lsb=1 and all are 0
		b=32'b1;
		$display("a=%b,b=%b",a,b);
		a='x; //here 'x=='bx== all x's
		b='bx;
		$display("a=%b,b=%b",a,b);
		a='z; //here 'z=='bz== all z's
		b='bz;
		$display("a=%b,b=%b",a,b);

	end
endmodule
