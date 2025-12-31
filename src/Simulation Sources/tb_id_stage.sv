`timescale 1ns / 1ps


module tb_id_stage();
logic        clk, RegWriteW;
logic [31:0] InstrD;
logic  [1:0] ImmSrcD;
logic [31:0] ResultW;
logic  [4:0] RdW;
logic [31:0] RD1D, RD2D, ImmExtD;

id_stage dut(clk, RegWriteW, InstrD, ImmSrcD, ResultW, RdW, RD1D, RD2D, ImmExtD);

always #5 clk=~clk;

initial begin
clk=0;
RegWriteW=1;
#10
InstrD=32'h00500113;
#10
InstrD=32'h00C00193;
RdW=5'd3;
ResultW=32'd12;
#10
InstrD=32'hFF718393;


end

endmodule
