class base;
	int a=10;
	virtual function void send();
		$display("base class a=%0d",a);
	endfunction
endclass

class e1 extends base;
int a;
function void send();
		$display("child 1 a=%0d",a);
	endfunction
endclass

class e2 extends e1;
	virtual function void send();
		$display("child 2");
	endfunction
endclass

module test;

	initial begin
	 e1 ec1,ec2,e3;
	e2 e21=new();
	base b1=new();
//	ec1=e21;
//	b1=e21;
//	ec1=new();
//	b1=ec1;
//	ec2=ec1;
	//e21=ec1;
//	b1=e21;
	$cast(ec1,b1);
//	ec2.a=34;
	b1.send();
	ec1.send();
//	ec2.a=20;
//	ec2.send();
//	e21.send();
//	$cast(ec2,b1);
//	ec2.send();
	end
endmodule
