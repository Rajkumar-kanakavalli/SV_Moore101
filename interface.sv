//---------------moore_101 Interface-----------------------------
interface seq_moore101(input clk,input rst);
 
      logic[2:0]x;
	  logic [2:0]y;
	  
	  
	clocking cb @(posedge clk);   //Clocking Block for DUT
	      output x;
		  input  y;
		  
	endclocking 
	
	clocking cb_mon_in @(posedge clk);    //Clocking Block for Input Monitor
	     input x;
		 output y;
	endclocking
	
	clocking cb_mon_out @(posedge clk);  //Clocking Block for Output Monitor
	   input y;
	   
	endclocking 
	
	//------------MODPORT DECLARATION-------------------------
	modport tb(clocking cb,input clk,input rst);
	
	modport tb_mon_in(clocking cb_mon_in,input x);
	
	modport tb_mon_out(clocking cb_mon_out,output y);
	
endinterface