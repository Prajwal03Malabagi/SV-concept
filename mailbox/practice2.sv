class trans;
	randc int a[];
	constraint co{a.size==10;}
	constraint co1{foreach(a[i]) a[i] inside{[0:30]};}

	function void post_randomize();	
		$display("the value=%p",a);
	endfunction
endclass

class generator;
	trans t1;
	mailbox #(trans) gen2driv;
	
	function new(mailbox #(trans) gen2driv);
		this.gen2driv=gen2driv;
		t1=new();
	endfunction
	
	task start();
	//	fork
			repeat(5)
			begin
			//	t1=new();
				t1.randomize();
				gen2driv.put(t1);
			end
	//	join
	endtask
endclass

class driver;
	trans t1;
	mailbox #(trans) gen2driv;

	function new(mailbox #(trans) gen2driv);
		this.gen2driv=gen2driv;
	endfunction
	
	task start();
//	fork
		repeat(10)
		begin
			gen2driv.get(t1);
		end
//	join_none
	endtask
endclass

class env;
	mailbox #(trans) gen2driv=new();
	generator gen=new(gen2driv);
	driver driv=new(gen2driv);
		
	task start();
	fork
		gen.start();
		driv.start();
	join
	endtask
endclass

module test;
initial begin
	env e;
	e=new();
	e.start();
end
endmodule

