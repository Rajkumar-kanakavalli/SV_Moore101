//-------------moore_101 Driver---------------------
class driver;
   packet got_pkt;
   mailbox #(packet) drv_mbx;
   //event e;
   virtual seq_moore101 vif_in;
    int repeat_count;
	
   function new(input mailbox #(packet) mbx,
                input virtual seq_moore101 vif_in,
				int repeat_count);
	this.drv_mbx =mbx;
	this.vif_in = vif_in;
	//this.e =e;
	this.repeat_count=repeat_count;
	endfunction
	
	extern task run();
	
endclass
//---------------------------------------------------	
   task driver::run();   // :: Scope Resolution Operator
  $display("-------------DRIVER RUN STARTED-----------------");
     forever
	 repeat(repeat_count)
		  begin
		  //wait(e);
		     drv_mbx.get(got_pkt);
		  
		  vif_in.x = got_pkt.x;
		  
		  $display("[Driver - Interface] X=%b \n",vif_in.x);
		  end
		  $display("-----------------DRIVER RUN ENDED-------------------");
		  endtask
	
      
	  
	  
		  