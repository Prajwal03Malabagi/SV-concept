module test;
	int i;
	class packet;
		static int pktc=0;
		int id;
		function star();
		id=pktc++;
		endfunction
	
		//function void display();
		//	$display("the id=%0d, pktc=%0d",id,pktc);
		//endfunction
	endclass

	class generator;
		task start1();
		//	packet pkt_h=star();
		endtask
	endclass
	
	generator ogen[2];
	generator egen[10];
	packet p;
	
	initial begin
	p=new();
//	ogen=new;
	foreach(ogen[i])
		ogen[i]=new;
	ogen[0].start1();
	p.star();
	$display("good=%0p",p.pktc);
	
	ogen[1].start1();
	$display("good=%0p",p.pktc);
	foreach(ogen[i])
		$display("ogen=%0d",ogen[i]);

	foreach(egen[i])
	begin
		egen[i]=new;
		egen[i].start1();
	end
	end
endmodule
