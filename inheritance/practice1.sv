class parent_trans;
	bit [7:0] header,payload;
	int parity;

	function new(int value=0);
		parity=value;
	endfunction
endclass

class error_trans extends parent_trans;
	bit error_parity;
	//bit payload;
	int d;
	
	function int have(int a);
		d=super.payload+a;
		return d;
	endfunction

	function new(int value=0);
		super.new(value);
	endfunction
endclass

module test;
	initial begin

		error_trans error_h,e1;
		error_h=new;
		error_h.header=34;
		error_h.error_parity=1;
		error_h.d=1;
		error_h.payload=20;
		error_h.have(43);
		e1=new(300);
		$display("the %0d, %0d",error_h.d,e1.parity);
	end
endmodule
