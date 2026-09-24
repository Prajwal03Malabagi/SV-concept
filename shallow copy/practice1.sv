
	class sub;
		int obj;
		function sub copy1();
			copy1=new();
			copy1.obj=this.obj;
		endfunction
	endclass

	class main;
		function sub copy1();
			copy1=new();
			copy1.obj=this.obj;
		endfunction

		sub s=new();
		function main copy1();
			copy1=new();
			copy1.data=this.data;
			copy1.s=this.s.copy1;
		endfunction
	endclass

	module test();
		main t1,t2;

	initial begin
		t1=new();
		t1.data=10;
		t1.s.obj=20;
		t2=t1.copy1;
		t2.s.obj=25;
		$display("%d & %d",t1.s.obj,t2.s.obj);
	end
	endmodule
