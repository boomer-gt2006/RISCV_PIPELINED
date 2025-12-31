`timescale 1ns / 1ps


module ex_stage(input  logic ALUSrcE, JumpE, BranchE,
                input  logic  [1:0] ForwardAE, ForwardBE,
                input  logic  [2:0] ALUControlE,
                input  logic [31:0] RD1E, RD2E, PCE, ImmExtE, ResultW, ALUResultM,
                output logic        PCSrcE,
                output logic [31:0] ALUResultE, WriteDataE, PCTargetE

    );
    
logic ZeroE;
logic [31:0] SrcAE, SrcBE;

//selecting input sources for ALU
mux3 #(32) srcamux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAE);
mux3 #(32) srcbmux(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
mux2 #(32) srcbemux(WriteDataE, ImmExtE, ALUSrcE, SrcBE);

//PC Branch
adder ex_add(PCE, ImmExtE, PCTargetE);

ALU ALU(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);

always_comb begin
    PCSrcE = 1'b0;   // safe default
    if (BranchE && ZeroE)
        PCSrcE = 1'b1;
    else if (JumpE)
        PCSrcE = 1'b1;
end

    

    
endmodule
