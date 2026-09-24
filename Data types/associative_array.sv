module mod;
	int a[string];
	initial begin
		a[3]=23;
		a[2]=21;
		a[20]=42;
		$display("no_of_entries=%0d",a.num());
		if(a.exists(21))
			$display("exist value 5");
		if(a.exists(2))
			$display("exist index 2");
		else
			$display("you can use in this way");	
		a["hi"]="hey";
		$display("a[hi]=%c,%0d",a["hi"],a.num());
		
		foreach(a[i])
			$display("array[%0d]=%0p",i,a[i]);
	end
endmodule
