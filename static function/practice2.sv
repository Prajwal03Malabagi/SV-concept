class transaction;
	static int i;
	int j;
	static function void stat_fun();
		int b;
	//	j++          because in static function we cannot access non static variable 
		i++;
		b++;
		$display("stat_fun, i=%0d,b=%0d",i,b);
	endfunction	
	function static void fun_stat();
		int a;
		i++;
		j++;
		a++;
		$display("fun stat, i=%0d,j=%0d,a=%0d",i,j,a);
	endfunction
	
	static function static void day();
		int a;
		i++;
		j++;
		a++;
		$display("fun stat, i=%0d,j=%0d,a=%0d",i,j,a);
	endfunction
endclass

	transaction t[];
module test;
	initial begin
		t=new[5];
		foreach(t[i])
		begin
			t[i]=new();
			t[i].stat_fun();
		end
		foreach(t[i])
			begin
				t[i].fun_stat();
			end
	end
endmodule 
	
