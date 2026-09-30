module up_down(clk,rst,din,load,mode,count);
  input clk,rst,load,mode;
  input [3:0]din;
  output reg [3:0]count;
  
  always @(posedge clk)
    begin
      if(rst)
        count<=0;
      else if(load)
        count<=din;
      else 
          begin
            if(mode)
            begin
              if(count==4'd12)
                count<=0;
              else
                count<=count+1;            
	    end
          else 
            begin              
		if(count==4'd0)
                count<=4'd12;
              else
                 count<=count-1;
            end	 
          end
    end
endmodule

interface intf(input  clk);
  logic rst,load,mode;
  logic [3:0] din;
  logic [3:0] count;
  
  clocking cb@(posedge clk);
    default input #1 output #1;
    output rst,load,mode;
    output din;
    input count;
  endclocking
  
  clocking cb_mon@(posedge clk);
	default input #1 output #1;
	input rst,load,mode,din,count;
  endclocking
  
  modport tb(clocking cb);
  modport mo(clocking cb_mon);
 
    endinterface
 
class transaction;
  rand bit load,mode;
  rand bit [3:0]din;
  bit rst;
  bit [3:0]ex_count;
  
  constraint co1{din inside{[0:12]};}
  
  task display(string mess);
    $display($time,"from:%s,rst=%d,load=%d,mode=%d,din=%d,count=%0d",mess,rst,load,mode,din,ex_count);
  endtask
endclass
    
class generator;
  transaction t;
  mailbox #(transaction) gen2driv;
  
  function new(mailbox #(transaction) gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
   virtual task run();
   fork 
    repeat(5)
      begin 
        t=new();
        assert(t.randomize());
        gen2driv.put(t);#30;
        t.display("gen");
      end
    join_none
  endtask
endclass
    
class driver;
  virtual intf.tb vi;
  transaction t;
  mailbox #(transaction) gen2driv;
  
  function new(virtual intf.tb vi,mailbox #(transaction) gen2driv);
    this.vi=vi;
    this.gen2driv=gen2driv;
  endfunction
  
  virtual task driv();
		@(vi.cb);
    vi.cb.din<=t.din;
    vi.cb.load<=t.load;
    vi.cb.mode<=t.mode;
  endtask
  
   virtual task run();
  fork
    repeat(5)
      begin
        gen2driv.get(t);
        driv();
        t.display("drv");
      end
   join_none
  endtask
endclass

class monitor;
  transaction t,t1;
  virtual intf vi;
  mailbox #(transaction) mon2scb;
  
  function new(virtual intf vi,mailbox #(transaction) mon2scb);
	this.vi=vi;
	this.mon2scb=mon2scb;
  endfunction

  task mons();
	t.load=vi.cb_mon.load;
	t.mode=vi.cb_mon.mode;
	t.din=vi.cb_mon.din;
	t.ex_count=vi.cb_mon.count;@(vi.cb_mon);
  endtask
 
  task run();
	fork
	repeat(5)
	begin
		t=new();
		mons();
		mon2scb.put(t);
		t.display("mon");
	end join_none
  endtask
endclass

class scoreb;
  transaction t1;
  bit[3:0] out;
  mailbox #(transaction) mon2scb;

 function new(mailbox #(transaction) mon2scb);
	this.mon2scb=mon2scb;
 endfunction

 task compa();
      if(t1.rst)
        out<=0;
      else if(t1.load)
        out<=t1.din;
      else 
          begin
            if(t1.mode)
            begin
              if(out==4'd12)
                out<=0;
              else
                out<=out+1;            
	    end
          else 
            begin              
		if(out==4'd0)
                out<=4'd12;
              else
                 out<=out-1;
            end	 
          end
  endtask

  task result();
	if(t1.ex_count==out)
		$display($time,"Pass------------ out=%d,ex_count",out,t1.ex_count);
	else 
		$display($time,"fail-----------   out=%d,ex_count",out,t1.ex_count);
  endtask

  task run(); fork
	repeat(5)
	begin  
		mon2scb.get(t1);
		compa();
		result();
	end join_none
  endtask
endclass
 
class env;
  virtual intf.tb vi;
  virtual intf.mo vif;
  mailbox #(transaction) gen2driv=new();
  mailbox #(transaction) mon2scb=new();
    
  generator gen;
  driver    drv;
  monitor   mon;
  scoreb    scb;
  
  function new(virtual intf.tb vi,virtual intf.mo vif);
    this.vi=vi;
    this.vif=vif;
  endfunction

  task reset();
  	vi.cb.rst <= 1;
  	vi.cb.load <= 0;
  	vi.cb.mode <= 0;
  	vi.cb.din  <= 0;
  	repeat(2) @(vi.cb);
  	vi.cb.rst <= 0;
  endtask

  
  task build();
    gen=new(gen2driv);
    drv=new(vi,gen2driv);
    mon=new(vif,mon2scb);
    scb=new(mon2scb);
  endtask
  
  task run(); 
	begin
      		gen.run();
      		drv.run();
		reset();
		@(vi.cb)
      		mon.run();
      		scb.run(); end
  endtask
endclass

class test;
  virtual intf.tb vif;
  virtual intf.mo vi;
  env e;
  function new(virtual intf.tb vif,virtual intf.mo vi);
	this.vif=vif;
	this.vi=vi;
  endfunction
  task run();
    e=new(vif,vi);
    e.build();
    e.run();
  endtask
endclass

module top;
  bit clk;
  intf vi(clk);
  test tt;
  up_down dut(.clk(clk),.rst(vi.rst),.din(vi.din),.load(vi.load),.mode(vi.mode),.count(vi.count));
  
  initial clk=0;
  always #5 clk=~clk;
	initial begin
		tt=new(vi,vi);
		tt.run();
      #500 $finish();
	end
endmodule
