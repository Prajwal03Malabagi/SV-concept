module mod;
	bit [7:0]d[];
	bit [7:0]q[$];
	bit [7:0]a[bit[0:6]];
	int dd[]={10,2,3,9,22};
	longint r1,r2,r3,r4,r5,r6,r7;
	bit[7:0] o1;
	bit[7:0] o2[$];
	bit[7:0] o3[$];

		typedef	struct {int name;
			logic[7:0]roll;
			bit[3:0]mark;
			}d1;
	d1 d2;

	initial begin
		d=new[10];
		foreach(d[i]) begin
			d[i]=$urandom_range(1,12);
			$display("d[%0d]=%0d",i,d[i]);
			q.push_front(d[i]);
			$display("front d[%0d]=%0d",i,d[i]); 
			q.push_back(d[i]);
	        	$display("back d[%0d]=%0d",i,d[i]); 
			end
		$display("d=%0p",d); 
		$display("q=%0p",q);
		foreach(q[i]) begin
			a[i]=q.pop_back();	
			$display("a[%0d]=%0d",i,a[i]);
		end
		$display("a=%0p",a);
		$display("---------------array reduction ----------------------");
	//	foreach(d[i])
			r1=d.sum() with(item>7?1:0);
			r5=d.product() with(item>3?item:0);
	//	foreach(q[i])
			r2=q.sum() with(item>7?1:0);
			r6=d.product() with(item>7?1:0);

	//	foreach(a[i])
			r3=a.sum() with(item>7?1:0);
			r7=d.product() with(item>7?1:0);

		r4=dd.sum() with(item>0?1:0);
		$display("a=%0p,r1=%0d\ndd=%0p,r4=%0d",d,r1,dd,r4);
		$display("d=%0p,r1=%0d,r5=%0d\nq=%0p,r2=%0d,r6=%0p\na=%0p,r3=%0d,r7=%0p",d,r1,r5,q,r2,r6,a,r3,r7);

		//	foreach(d[i])
			r1=d.sum() with(item>7?item:0);
		foreach(q[i])
			r2=q.sum() with(item>7?item:0);
	//	foreach(a[i])
			r3=a.sum() with(item>7?item:0);
		r4=dd.sum() with(item>0?1:0);
		$display("a=%0p,r1=%0d\ndd=%0p,r4=%0d",d,r1,dd,r4);
		$display("d=%0p,r1=%0d\nq=%0p,r2=%0d\na=%0p,r3=%0d",d,r1,q,r2,a,r3);


		$display("------------------array sorting methods---------------");
		d.sort;
		$display("sort=%0p",d);
		d.reverse();
		$display("reverse=%0p",d);
		d.shuffle();
		$display("shuffle=%0p",d);
		d.rsort();
		$display("rsort=%0p",d);

		$display("--------------array locator--------------");
		
	/*	o1=d.max();
		$display("d=%0p",o1); // gives error because o1 is packed array and d is unpacked array so we cannot do o1=d;*/
		o2=a.min();
		$display("d=%0p",o2);
		o3=a.unique();
		$display("d=%0p,a=%0p",o3,a);
		o2=a.find() with(item>3);
		$display("find no(item>3) o2=%0p",o2);
		o3=d.find_first with(item>3);
		$display("find first(item>1)o3=%0p",o3);

		$display("-------------struct types----------------");

	/*
		d1.name="prajwal";
		d1.roll=8'd22;
		d1.mark=4'd12;*/
		d2='{32'd32,8'd22,8'd12};
		$display("struct=%0p",d2);

		end


endmodule
