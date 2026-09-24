
module jk;
	
static int i;
	initial begin
		for(i=0;i<3;i++)begin
			#1;
			fork
			 automatic int k=i;
				$display($time,"i=%0d,k=%0d",i,k);
			join_none
		end
	end
endmodule

// k is automatic so it has separate memory and where i is static it has shared memory 

//scenario based question

/*
module jk;
	semaphore s1=new(1);
	semaphore s2=new();	
	semaphore s3=new();
	semaphore s4=new();

	initial begin
		fork
			begin:b1
				s1.get(1);
				$display("process 1");
				s3.put(1);
			end
			begin:b2
				s2.get(1);
				$display("process 2");
				s4.put(1);
			end
			begin:b3
				s3.get(1);
				$display("process 3");
				s2.put(1);
			end
			begin:b4
				s4.get(1);
				$display("process 4");
			end
		join
			$display("fork-joinnone");
	end
endmodule
*/
// fork-join_any using fork-join_none 
/*
module test;
	event e,e1;
	initial begin
		 fork
		
			begin #1;->e; $display("1st");end
			begin #2;->e1; $display("2nd");end
		join_none
		wait(e.triggered || e1.triggered);
		$display("hi");
	//	#100 $finish();			
	end
endmodule

*/
//fork-join using fork-join_none
/*
module test;
	event e,e1;
	initial begin
		 fork
		
			begin #1;->e; $display("1st");end
			begin #2;->e1; $display("2nd");end
		join_none
		wait(e.triggered);
		wait( e1.triggered);
		$display("hi");
		#100 $finish();			
	end
endmodule
*/
//fork-join using fork-join_any
/*
module test;
	event e,e1;
	initial begin
		 fork
		
			begin #1;->e; $display("1st");end
			begin #2;->e1; $display("2nd");end
		join_any
		wait(e.triggered);
		wait (e1.triggered);
		$display("hi");
	//	#100 $finish();			
	end
endmodule
*/
//fork-join_none using fork-join_any
/*
module test;
	event e,e1;
	initial begin
		 fork
		//	->e;
				#1;
			 #1  $display("1st");
			 #2  $display("2nd");
			begin end
		join_any
	//	wait(e.triggered)
		$display("hi");
	//	#100 $finish();			
	end
endmodule
*/
// predict the output 
/*
module tb;
	initial begin
	 int i;
		for(i=0;i<3;i++)
			fork 
				$display("i=%0d",i);
			join 
	end
endmodule
*/




