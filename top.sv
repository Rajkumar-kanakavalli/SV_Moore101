`include "interface.sv"
`include "DUT.sv"
`include "program.sv"

module top;
 bit clk;
 bit rst;
 
 always #5 clk=~clk;
 
 initial begin
 
    clk=0; rst=1;
 #5  clk=1; rst=0;
 //#10  clk=1; rst=0;
 //#20  clk=1; rst=0;

end
   seq_moore101 intf(clk,rst);    //Interface Instantiation
   
    moore_101 dut(intf);    //DUT Instantiation
   
   program_test testbench(intf);  //program block instantiation
   
   endmodule