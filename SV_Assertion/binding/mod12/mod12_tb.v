module mod_tb;
	logic clk,rst,load,mode;
	logic [3:0] din,count;
	
	mod dut(clk,rst,din,load,mode,count);
	bind mod mod_assert duv(clk,rst,din,load,mode,count);

	always #5 clk=~clk;

	task reset();
		rst=0;
		@(negedge clk)rst=1;
		@(negedge clk)rst=0;
	endtask

	task data();
		load=1;
		@(negedge clk) din=$urandom_range(0,11);
		mode=0;
	endtask

	task data_mode();
		mode=0;
		load=0;
		repeat(2) @(negedge clk) mode=1;@(negedge clk);
		mode=1;load=0;
	endtask

	initial begin
		clk=0;
		reset();
		#10;data();#20;
		data_mode();#40;
		
		#40 $finish();
	end

	initial $monitor($time,"clk=%0d,rst=%0d,load=%0d,mode=%0d,din=%0d,count=%0d",clk,rst,load,mode,din,count);
endmodule
