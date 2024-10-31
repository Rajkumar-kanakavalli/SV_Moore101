//-------------- moore_101 Output Monitor------------------
class output_monitor;
    packet pkt;
	mailbox #(packet) mbx;
	virtual seq_moore101.tb_mon_out vif;
	
	function new(input mailbox #(packet) mbx_in,
	             input virtual seq_moore101.tb_mon_out vif);
	this.mbx = mbx_in;
	this.vif = vif;
	endfunction
	
	extern task run();
	endclass
//------------------------------------------------------------
  task output_monitor::run(); //  :: Scope Resolution Operator
   $display("\n----------OUTPUT MONITOR RUN STARTED---------------");
   $display("[OUTPUT MONITOR] Run started at time=%0t \n",$time);
   
    forever
	
	   begin
	    pkt= new();
//Pin Level to Packet Level Conversion
		@(pkt.y);
		pkt.y = vif.y;            
		
	$display($time,"[OUTPUT MONITOR]  X=%b Y=%b",pkt.x,pkt.y); 
		mbx.put(pkt);

		$display("------------OUTPUT MONITOR END------------ \n");
		
		end
		endtask
