`timescale 1ns / 1ps


module tb_if_stage();

logic clk, reset, PCSrcE, stallF;
logic [31:0] PCTargetE, PCPlus4F, InstrF, PCF;

if_stage dut(clk, reset, PCSrcE, stallF, PCTargetE, PCPlus4F, InstrF, PCF);



always #5 clk=~clk;

initial begin
reset=1;
clk=0;
#20 reset=0;
PCSrcE=0;
stallF=0;
#40
stallF=1;
#20
stallF=0;

end

endmodule
