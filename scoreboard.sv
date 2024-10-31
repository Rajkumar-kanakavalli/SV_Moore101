//------------moore_101 Scoreboard----------------
class scoreboard;
   packet ref_pkt;  //handle creation
   packet got_pkt;
   
   mailbox #(packet) ipm_sbd;  //mailbox creation
   mailbox #(packet) opm_sbd;
   
   function new(input mailbox #(packet) ipm_sbd,
                input mailbox #(packet) opm_sbd);
	
	this.ipm_sbd = ipm_sbd;
	this.opm_sbd = opm_sbd;
	endfunction
	
	extern task run();
	
	endclass
 //--------------------------------------------------  
 task scoreboard::run(); //  :: Scope Resolution Operator
       $display("--------------SCOREBOARD RUN STARTED-----------");
	   
	   while(1)   //acts as forevr loop
	     
	     begin
		 ipm_sbd.get(ref_pkt);
		 opm_sbd.get(got_pkt);
		 
		 
		 $display("[SOCREBOARD] [REFERNCE OUTPUT] Y=%0b, [DUT OUTPUT] Y=%0b \n ",ref_pkt.y,got_pkt.y);
		 if(ref_pkt.y == got_pkt.y)
		      $display("******************TEST CASE PASS*************");
			  else
			  $display("*********************TEST CASE FAILED*************");
			  end
			  $display("************SOCREBOARD RUN END*****************");
			 $finish;
			 endtask
