`timescale 1ns / 1ps


module tb_dmem();

logic clk, we;
logic [31:0] a, wd, rd;

dmem dut(clk, we, a, wd, rd);

always #5 clk = ~clk;

initial begin
clk=0;
we=0;
#10
a=32'd4;
wd=32'd10;
we=1;
#10
we=0;
#10
a=32'd8;
wd=32'd20;
we=1;
#10
we=0;
#10
a=32'd12;
wd=32'd30;
we=1;
#10
we=0;
end

endmodule
