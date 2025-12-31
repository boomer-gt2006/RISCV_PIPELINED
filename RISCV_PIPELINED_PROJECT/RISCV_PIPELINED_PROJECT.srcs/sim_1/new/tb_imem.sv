`timescale 1ns / 1ps


module tb_imem();
logic [31:0] PC, Instr;

imem dut(PC, Instr);

initial PC<=0;

always #4 PC<=PC+4;
endmodule
