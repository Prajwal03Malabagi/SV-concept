module mod;

	reg [3:0]data;
	wire [3:0]sig;

	assign sig=4'bz;
	
	initial begin
		data=4'bx10;
		$display("data=%0b,sig=%0b",data,sig);
		if($isunknown(data)) //consider both x  and  z as unknown
			$display("data is unknown");
		else
			$display("data is known");
		if($isunknown(sig))
			$display("sig is unknown");
		else
			$display("sig is known");
	end
endmodule

