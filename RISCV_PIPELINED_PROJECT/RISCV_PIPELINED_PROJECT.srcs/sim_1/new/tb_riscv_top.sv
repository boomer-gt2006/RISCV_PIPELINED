`timescale 1ns / 1ps

module tb_riscv_top();
logic clk, reset, MemWrite;
logic [31:0] WriteData, DataAdr, PC, Instr;

 // instantiate device to be tested
 riscv_top dut(clk, reset, MemWrite, WriteData, DataAdr, PC, Instr);
 // initialize test
 initial
 begin
 reset = 1; # 22; reset = 0;
 end
 
 initial clk=0;
 // generate clock to sequence tests
 always
 begin
 clk = 1; # 5; clk = 0; # 5;
 end
 // check results


endmodule
