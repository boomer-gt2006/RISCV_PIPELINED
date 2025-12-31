`timescale 1ns / 1ps


module tb_controller();
logic [6:0] op;
logic [2:0] funct3;
logic       funct7b5;
logic [1:0] ResultSrc;
logic       MemWrite;
logic       ALUSrc;
logic       RegWrite, Jump, Branch;
logic [1:0] ImmSrc;
logic [2:0] ALUControl ;

controller dut(op, funct3, funct7b5, ResultSrc, MemWrite, ALUSrc, RegWrite, Jump, Branch, ImmSrc, ALUControl);

logic [31:0] Instr;
assign op = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7b5 = Instr[30];

logic [31:0]RAM[0:20];

initial $readmemh("riscvtext.txt", RAM);

initial begin
for(int i = 0; i<=20; i++) begin
        Instr = RAM[i];
        #10;
        end
end


endmodule
