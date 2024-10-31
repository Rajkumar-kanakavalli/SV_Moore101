//------------moore_101   Generator------------------
class  generator;
   packet pkt;
   mailbox #(packet) gen_box;
   //event e;
   logic [3:0]no_of_pkts;
   
   function new(mailbox #(packet) mbx,logic [3:0]no_of_pkts); //Explicit Object Argument
    this.gen_box = mbx;
	//this.e = e;
	this.no_of_pkts= no_of_pkts;
   endfunction
 
    extern task run();
  
 endclass
 //----------------------------------------
 task generator::run();
 $display("\n--------------Generator RUN STARTED---------------");
   pkt = new();
   repeat(no_of_pkts)
   
       begin
	    $display($time,"[Generator] number of Packets=%0d",no_of_pkts);
	   assert(pkt.randomize());
	   
	   $display("[Generator] X=%b  Y=%b \n",pkt.x,pkt.y);
	   
	   gen_box.put(pkt);
	   //#10;
	   //->e;    //Triggering event
      end
	  $display("--------------Generator RUN END-------------");
	  
endtask
   
   