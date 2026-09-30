module in_line(clk,rst,load,din,dout);
	input logic clk,rst,load;
	input logic [3:0]din;
	output logic [3:0]dout;

	always@(posedge clk)
	begin
		if(rst)
			dout<=0;
		else if(load)
			dout<=din;
		else
			dout<=dout+1;
	end
	property counter;
		@(posedge clk) load |=> dout ==din;
	endproperty
	property counter1;
		@(posedge clk) !load |=> dout==($past(dout))+1;
	endproperty
	counter_check : assert property(counter);
	counter_check1: assert property(counter1);


endmodule

module in_line_tb;
	logic clk,rst,load;
	logic [3:0]din,dout;
	
	in_line dut(clk,rst,load,din,dout);
	
	always #5 clk=~clk;
	
	initial begin
		clk=0;
		rst=0;
		#10; rst=1;
		#10; rst=0;
		load=1;din=2;
		#10; load=0;
		#10;load=1;
		#100 $finish();
	end
	initial $monitor($time,"clk=%d,rst=%d,load=%d,din=%0d,dout=%0d",clk,rst,load,din,dout);
endmodule
