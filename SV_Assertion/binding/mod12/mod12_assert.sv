module mod_assert(clk,rst,din,load,mode,count);
	input logic clk,rst,load,mode;
	input logic [3:0] din,count;

	property loading;
		@(posedge clk) disable iff(rst)
			(load) |-> ##1 (count==din);
	endproperty 
	property mode_check;
		@(posedge clk) disable iff(rst)
			(!load && mode) |=> if( count==12) count==0;
				else count==$past(count)+1;
	endproperty

	property mode_zero;
		@(posedge clk) disable iff(rst)
			(!load && !mode) |=>if(count==0) ##1 count==12;
				else ##1 count==$past(count,1)-1;
	endproperty
	         
	lo:assert property(loading) $display("loading");
	mo:assert property(mode_check) $display("mode 1");
	Mo:assert property(mode_zero) $display("mode 0");
endmodule
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
