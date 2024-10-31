//-------------------moore_101  Packet------------------------------
class packet;

    // bit clk,rst;
	 rand bit [2:0]x;   //input signals
      
	  bit [2:0]y; //output
                   
 
     bit prev_x; 
      
 
 constraint c1{x inside{[0:7]};      //constraint declaration
                x != prev_x;}
			   
			   
			   
   function void post();
         prev_x = x;
         endfunction	   
			   
endclass

 