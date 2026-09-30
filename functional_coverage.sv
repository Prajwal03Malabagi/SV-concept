/*1.Write a covergroup to collect coverage for a 4-bit signal data.

Requirements:

Cover all values from 0–15.
Ignore values 12–15.*/

/*
module mod;
	
	bit[3:0]data;
	
covergroup cg;
	c1:coverpoint data{bins b[]={[0:15]};
			   ignore_bins b1[]={[12:15]};}
endgroup

	cg c;
	initial begin
	c=new();

		for(int i=0;i<16;i++)
		begin
			data=i;
			c.sample();
	//	end
		$display("%0d",c.get_coverage());
	end
	end
endmodule */
	
/*
2. Create a covergroup for

bit [1:0] mode;

Create bins for

IDLE = 0
READ = 1
WRITE = 2
ERROR = 3
*/
/*
module mod;
	bit [1:0]mode;
	
	covergroup cg;
		c1:coverpoint mode{bins idle={0};
				   bins read={1};
				   bins write={2};
				   bins error={3};}
	endgroup
	
	initial begin
		cg c;
		c=new();
		c.randomize();
		c.sample();
		$display("%0d",c.get_coverage());
	end
endmodule*/

// 3. 4 bit data bins to be created for 0,1-3,4-7,8-11,12-14,15
/*
class random;
	rand bit[3:0]data;
	
	covergroup cg;
		c1:coverpoint data{bins b1={0};
				   bins b2={[1:3]};
				   bins b3={[4: 	  7]};
					bins b4={[8:11]};
					illegal_bins b5={[12:14]};   // the code will give error if we get any of this value
					ignore_bins b6={15};}       // ignore bins element are valid but do not contribute for coverage
	endgroup

	function new();
        	cg = new();
    	endfunction
	
	function void post_randomize();	
		$display("data=%0d",data);
	endfunction
endclass
module mod;
	random r;
	initial begin
		repeat(10) begin
		r=new();
		r.randomize();
		r.cg.sample();end
		$display(r.cg.get_coverage());
	end
endmodule
*/
/*
class apb_txn;
  rand bit        pwrite;
  rand bit [7:0]  paddr;
  rand bit [31:0] pwdata;
endclass

Write a functional coverage model that covers:

pwrite = 0
pwrite = 1
paddr values from 0x00 to 0x0F
paddr values from 0x10 to 0xFF
*/
/*
class apb_txn;
  rand bit        pwrite;
  rand bit [7:0]  paddr;
  rand bit [31:0] pwdata;
	
  function void post_randomize();
	$display("pwrite=%0d,paddr=%0d,pwdata=%0d",pwrite,paddr,pwdata);
  endfunction
endclass

module mod;
apb_txn tx;
covergroup cg;
//	option.per_instance=1;
	c1:coverpoint tx.pwrite{bins b[]={0,1};}
	c2:coverpoint tx.paddr{bins b1={['h00:'h0f]};}
endgroup
cg c,c1,c2;
bit[3:0] a;
initial begin
	tx=new();
	c=new();
	c1=new();
	c2=new();
	repeat(30)begin
	tx.randomize();
	c.sample();end
	a=c.get_coverage();
	$display(a);
	repeat(1)
	begin
		tx.randomize();
		c1.sample;end
	$display(c.get_coverage());
	
end

endmodule
*/

/*
Signal cmd_type is 3-bit (8 possible values), but you only care about values 0,1,2 individually — everything else should fall into one bin called unused. (Concept: explicit bins, default)*/
/*
class random;
	rand bit[2:0]cmd;
	
	covergroup cg;
		C1:coverpoint cmd{bins b1[]={0,1,2};
				ignore_bins b2={3};
				illegal_bins b3={4};
				bins b4={5,6,7};
				 bins b=default;}
	endgroup
	constraint co{cmd inside{[3:6]};}
	function new();
		cg=new();
	endfunction

endclass
*/
/*
class random;
	rand bit[3:0]a,b,c;
	rand bit d;
	
	covergroup cg;
	option.per_instance=1;
	option.auto_bin_max=30;
		C1:coverpoint a{bins a1={[0:2]};
				bins a2={[3:4]};
				ignore_bins a3={[5:6]};
				illegal_bins a4={[7:8]};
				bins a5=default;
				bins a6=(4=>3);}

		C2:coverpoint b{bins b1={[0:2]};
				bins b2={[3:4]};
				ignore_bins b3={[5:6]};
				illegal_bins b4={[7:8]};
				bins b5=default;}
		C3:coverpoint c{bins c1={[0:2]};
				bins c2={[3:4]};
				ignore_bins c3={[5:6]};
				illegal_bins c4={[7:8]};
				bins c5=default;}
		C4:coverpoint d{bins d1={0};
				illegal_bins d2={1};}
		
		C5:cross C1,C2,C3,C4;
	endgroup
	constraint c1{a inside {[0:4],[9:16]};}
	constraint c2{b inside {[0:4],[9:16]};}
	constraint c3{c inside {[0:4],[9:16]};}
	constraint c4{d==0;};
	function new();
		cg=new();
	endfunction
endclass
*/
/*
class random;
	rand bit [3:0]a,b;
	rand bit [7:0]d;
	
	covergroup cg;
	option.per_instance=1;
		C1: coverpoint a{bins b1={0};
				bins b2=(1=>2);
				bins b3={3,4};
				bins b4=(5=>6=>7);
				}
		C2: coverpoint d{bins a1[]={[0:4]};
				bins a2[]=(5=>6,7);
				bins a3={8,9,10};
				bins a4={11,12,13};
				bins a5={14,15};
				}
		C3:coverpoint b{bins d1=(0=>1);
				bins d2=(2=>3);
				bins d3={4,5,6};
				bins d4={7};
				}
	C4:cross C1,C2,C3;
	endgroup

	function new();
		cg=new();
	endfunction

endclass
*/

class random;
	rand bit[7:0]a,b;
	constraint co{a>=6;}
	constraint c1{b>1;}
	covergroup cg;		
		option.per_instance=1;

		C1:coverpoint a{bins a1[]={6,7};
				ignore_bins a2[]={[0:3]};
				illegal_bins a3[]={[4:5]};
				}
		C2:coverpoint b{bins b1[]={[2:6]};
				ignore_bins b2={0,1};
				bins b3=(4=>5);
				bins b4={7};
				}
	endgroup
	
	function new();
		cg=new();
	endfunction
	
	endclass
	
module mod;
	random r;
	initial begin
		r=new();
		repeat(550)
		begin
			r.randomize();
			r.cg.sample();
			$display(r.cg.get_coverage());
		end
	end
endmodule
