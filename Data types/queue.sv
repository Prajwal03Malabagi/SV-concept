module mod;
	int q[$];
	int a[$];
	initial begin
	q.push_front(1);
	q.push_front(32);
	q.push_front(12);
	q.insert(3,33);
	q.push_front(2);
	q.insert(2,123);
	foreach(q[i])
		$display("q=%0d",q[i]);
	$display("qarray=%0p",q);
	a=q.find_first(x) with (x>12);
	$display("find_first=%0p",a);
	a.delete();

	a=q.find_first_index(x) with (x>12);
	$display("find_first_index=%0p",a);
	
	a=q.find_last(x) with (x);
	$display("find_last=%0p",a);

	a=q.find_last_index(x) with (x);
	$display("find_last_index=%0p",a);
	
	a=q.min();
	$display("min=%0p",a);

	a=q.max();
	$display("max=%0p",a);
	
	a=q.unique();
	$display("unique=%0p",a);
	a.delete();
	a=q.unique_index;
	$display("unique_index=%0p",a);
	end
endmodule
