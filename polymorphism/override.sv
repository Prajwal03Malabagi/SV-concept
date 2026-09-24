class over;
	int a=4;
	function int val();
		int data=7;
		return data;
	endfunction

	virtual function int val1();	
		int data=13;
		return data;
	endfunction
endclass

class game extends over;
	int a=5;
	function int val();
		int data=6;
		return data;
	endfunction
endclass

module test();
	game g1,g2;
	over o1;
	
	initial begin
		g1=new();
		o1=new();
		$display(" the game %0p",g1);
		
		$display("the game a=%0d,data=%0d",g1.a,g1.val);
		$display(" the over %0p",o1);
		$display("the over a=%0d,data=%0d",o1.a,o1.val);
	//	g1=o1;
		o1=g1;
		$cast(g1,o1);
		$display(" the game %0p",g1);
		$display("the game a=%0d,data=%0d",g1.a,g1.val);
		$display(" the over %0p",o1);
		$display("the over a=%0d,data=%0d",o1.a,o1.val);
	$display("the over a=%0d,data=%0d",o1.a,o1.val1);
		
	end
endmodule

		
