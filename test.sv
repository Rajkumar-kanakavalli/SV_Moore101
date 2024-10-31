`include "environment.sv"
 class  base_test;
     
	 environment env;
	 
	 virtual seq_moore101.tb vif_in;
	 virtual seq_moore101.tb_mon_in vif_mon_in;
	 virtual seq_moore101.tb_mon_out vif_mon_out;
	 
	 function new(input virtual seq_moore101.tb vif_in,
	              input virtual seq_moore101.tb_mon_in vif_mon_in,
				  input virtual seq_moore101.tb_mon_out vif_mon_out);
	this.vif_in = vif_in;
	this.vif_mon_in = vif_mon_in;
	this.vif_mon_out = vif_mon_out;
	endfunction
	
	function  void build();
 env = new(vif_in,vif_mon_in,vif_mon_out);
 endfunction
 
 task run();
     $display("\n [TEST CASE] Run started at time=%0t",$time);
     build();
     env.run();
     $display("[TEST CASE] Run ended at time=%0t",$time);
 endtask
	
	
endclass	

 
	