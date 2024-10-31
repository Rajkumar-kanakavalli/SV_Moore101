`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "input_monitor.sv"
`include "output_monitor.sv"
`include "scoreboard.sv"
//-----------moore_101  Environment------------------------------
class environment;

    generator gen; 
	driver drv;
	input_monitor mon_in;
	output_monitor mon_out;
	scoreboard scb;
	
	mailbox #(packet) gen_drv_mbx; // 3 mailbox creations
	mailbox #(packet) ipm_scb_mbx;
	mailbox #(packet) opm_scb_mbx;
	
	virtual seq_moore101.tb vif_in;
	virtual seq_moore101.tb_mon_in vif_mon_in;   //3interface creations
	virtual seq_moore101.tb_mon_out vif_mon_out;
	int repeat_count;
	logic [3:0] no_of_pkts;
	//event e;
	
	function new(input virtual  seq_moore101.tb vif_in,
	             input virtual seq_moore101.tb_mon_in vif_mon_in,
				 input virtual seq_moore101.tb_mon_out vif_mon_out);
				 
	this.vif_in =  vif_in;
	this.vif_mon_in = vif_mon_in;
	this.vif_mon_out = vif_mon_out;
	endfunction
	//extern function void build();
	//extern task run();
	
	
function void build();
    gen_drv_mbx = new();
	ipm_scb_mbx = new();
	opm_scb_mbx = new();
	
	gen     = new(gen_drv_mbx,no_of_pkts);
	drv     = new(gen_drv_mbx,vif_in,repeat_count);
	mon_in  = new(ipm_scb_mbx,vif_mon_in);
	mon_out  = new(opm_scb_mbx,vif_mon_out);
	scb      = new(ipm_scb_mbx,opm_scb_mbx);
endfunction

task run();
     $display("\n [ENVIRONMENT] Run Started at Time=%0t",$time);
	 repeat_count=2;
	 build();
	 fork
	 gen.run();
	 drv.run();
	 mon_in.run();
	 mon_out.run();
	 scb.run();
	 join
	 //#10;
	 endtask
	endclass
//-------------------------------------------------------------
 

	 










	
	
	