//-------------moore_101 Input Monitor---------------------------
class input_monitor;
     packet pkt;
	 mailbox #(packet) mbx;
	 virtual seq_moore101.tb_mon_in vif;
	 //event e;
	 
	 parameter s1=2'b00, s2=2'b01, s3=2'b10, s4=2'b11;
      reg [1:0] cs,ns;

	 function new(input mailbox	#(packet) mbx_in,
	              input virtual seq_moore101.tb_mon_in vif);
				  
	this.mbx = mbx_in;
	this.vif = vif;
	//this.e = e;
	endfunction
	
	extern task run();
	endclass
  //---------------------------------------------------------------
 
 task input_monitor::run();   //  :: Scope Resolution Operator
   $display("--------------INPUT Monitor RUN STARTED----------------");
   pkt = new();
   $display("[INPUT MONITOR] Run started at time=%0t",$time);
  forever
    begin
	//wait(e);
	 
	 //Pin level to Packet level conversion
        @(vif.x)
	    //pkt.y =vif.y;      
	
//REFERNCE BFM LOGIC  ------OR------Dummy DUT------------
	
	
	case (cs)
s1: if(pkt.x == 0)
    ns <= s1;
    else
    ns <= s2;   // sequence - 1 detected
s2: if(pkt.x == 0)
    ns <= s3;   // sequence - 0 detected
    else
    ns <= s2;   
s3: if(pkt.x == 0)
    ns <= s1;
    else
    ns <= s4;   // sequence - 1 detected 
s4:if(pkt.x == 0)
    //ns <= s1;//(non-overlapping)
    ns = s3; //(overlapping)
    else
    ns <= s2;//s1
default: ns <= s1;
endcase
 assign  pkt.y = (cs == s4)?1:0;    // state 4 ---- 1-0-1 detected hence output = 1 else output =0

 $display($time,"[INPUT MONITOR]  X=%b Y=%b",pkt.x,pkt.y); 
	 mbx.put(pkt);
	 $display("----------INPUT MONITOR END-------- \n");
	 
	 end
endtask

	
 
  