class trans;
  rand bit[2:0]a[];
  
  constraint co{a.size==10;foreach(a[i]) a[i] inside{[0:5]};}
  
  function void display(input string mess);
    $display("%s",mess);
    $display("the arrray=%p",a);
  endfunction
endclass

class generator;
  trans t;
  mailbox #(trans) gen2driv;
  
  function new(mailbox #(trans) gen2driv);
    this.gen2driv=gen2driv;
    t=new();
  endfunction
  
  task run;
    repeat(5)begin
      t.randomize();
      gen2driv.put(t);
      t.display("from generator");
    end
  endtask
endclass

class driver;
  trans t;
  mailbox #(trans) gen2driv;
  
  function new(mailbox #(trans) gen2driv);
    this.gen2driv=gen2driv;
  endfunction
  
  task run;
    repeat(5)begin
      gen2driv.get(t);
      t.display("from driver :");end
  endtask
endclass

class env;
  mailbox #(trans) gen2driv=new();
  generator gen;
  driver driv;
  
  task build;
    gen=new(gen2driv);
    driv=new(gen2driv);
  endtask
  
  task run;
    fork
    gen.run;
    driv.run;
    join_none;
  endtask
endclass

module test;
  env e;
  initial begin
    e=new();
    e.build;
    e.run;
  end
endmodule
  
      
