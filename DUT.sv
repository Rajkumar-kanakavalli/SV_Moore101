

module  moore_101  (seq_moore101 dut_if);
       
      parameter s1=2'b00, s2=2'b01, s3=2'b10, s4=2'b11;
      reg [1:0] cs,ns;

always @(posedge dut_if.clk)
begin
if (!dut_if.rst)   //
cs <= s1;
else 
cs <= ns;
end 

always @(cs,dut_if.x)
begin
case (cs)
s1: if(dut_if.x == 0)
    ns <= s1;
    else
    ns <= s2;   // sequence - 1 detected
s2: if(dut_if.x == 0)
    ns <= s3;   // sequence - 0 detected
    else
    ns <= s2;   
s3: if(dut_if.x == 0)
    ns <= s1;
    else
    ns <= s4;   // sequence - 1 detected 
s4:if(dut_if.x == 0)
    //ns <= s1;//(non-overlapping)
    ns = s3; //(overlapping)
    else
    ns <= s2;//s1
default: ns <= s1;
endcase 
end 

    assign dut_if.y = (cs == s4)? 1:0;    // state 4 ---- 1-0-1 detected hence output = 1 else output =0

endmodule  
