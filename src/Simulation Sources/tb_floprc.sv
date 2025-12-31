`timescale 1ns / 1ps


module tb_floprc();
logic clk, reset, clr;
logic [31:0] d, q;

floprc #(32) dut(clk, reset, clr, d, q);

always #5 clk=~clk;

initial begin
clk=0;
reset=1;
clr=0;
d=32'd4;
#12;
reset=0;
#10
d=32'd10;
end

endmodule
