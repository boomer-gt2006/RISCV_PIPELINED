`timescale 1ns / 1ps


module riscv_top(input  logic clk, reset,
output logic        MemWriteM,
output logic [31:0] WriteDataM, ALUResultM, PCF,InstrF

    );
    


//Control Signals
    
    //Decode Stage Signals
    logic       MemWriteD, ALUSrcD, RegWriteD, JumpD, BranchD;
    logic [1:0] ImmSrcD, ResultSrcD;
    logic [2:0] ALUControlD;

    
    //Execute Stage Signals
    logic       PCSrcE, ALUSrcE, JumpE, BranchE, RegWriteE, MemWriteE;
    logic [1:0] ResultSrcE;
    logic [2:0] ALUControlE;

    
    //Memory Stage Signals
    logic       RegWriteM, MemWriteM;
    logic [1:0] ResultSrcM;

    
    //Writeback Stage Signals
    logic       RegWriteW;
    logic [1:0] ResultSrcW;


//Datapath Signals
   
    //Fetch Stage Signals

    logic [31:0] InstrF, PCF, PCPlus4F;
    
    //Decode Stage Signals

    logic [4:0] Rs1D, Rs2D;
    logic [31:0] InstrD, PCD, PCPlus4D, ImmExtD, RD1D, RD2D;
    
    //Execute Stage Signals

    logic [4:0]  Rs1E, Rs2E, RdE;
    logic [31:0] PCTargetE, RD1E, RD2E, PCE, ImmExtE, PCPlus4E, ALUResultE, WriteDataE;
    
    //Memory Stage Signals

    logic [4:0]  RdM;
    logic [31:0] ALUResultM, PCPlus4M, ReadDataM, WriteDataM;
    
    //Writeback Stage Signals

    logic [4:0]  RdW;
    logic [31:0] ResultW, PCPlus4W, ALUResultW, ReadDataW;

//Hazard Signals

logic       StallF, StallD;//stall signals
logic       FlushD,  FlushE;//flush signals
logic [1:0] ForwardAE, ForwardBE;//forwarding signals

assign {Rs2D, Rs1D}=InstrD[24:15];
//Datapath
    //Fetch Stage
    if_stage fetch(clk, reset, StallF, PCSrcE, PCTargetE, PCPlus4F, InstrF, PCF);
    
    //flopenrc #(96) if_to_id(clk, reset, StallD, FlushD, {InstrF, PCF, PCPlus4F}, {InstrD, PCD, PCPlus4D});
    
    flopenrc #(32) instr_if_id_pipe(clk, reset, StallD, FlushD, InstrF, InstrD);
    flopenrc #(32) pc_if_id_pipe(clk, reset, StallD, FlushD, PCF, PCD);
    flopenrc #(32) pc4_if_id_pipe(clk, reset, StallD, FlushD, PCPlus4F, PCPlus4D);
    
    //Decode Stage
    id_stage decode(clk, RegWriteW, InstrD, ImmSrcD,ResultW, RdW, RD1D, RD2D, ImmExtD);
    
   // floprc #(175) id_to_ex(clk, reset, FlushE, {RD1D, RD2D, PCD, InstrD[24:20], InstrD[19:15], InstrD[11:7], ImmExtD, PCPlus4D}, {RD1E, RD2E, PCE, Rs2E, Rs1E, RdE, ImmExtE, PCPlus4E});
    

    floprc #(32) rd1_pipe   (clk, reset, FlushE, RD1D, RD1E);
    floprc #(32) rd2_pipe   (clk, reset, FlushE, RD2D, RD2E);
    floprc #(32) pc_pipe    (clk, reset, FlushE, PCD,  PCE);
    floprc #(5)  rs1_pipe   (clk, reset, FlushE, InstrD[19:15], Rs1E);
    floprc #(5)  rs2_pipe   (clk, reset, FlushE, InstrD[24:20], Rs2E);
    floprc #(5)  rd_pipe    (clk, reset, FlushE, InstrD[11:7],  RdE);
    floprc #(32) imm_pipe   (clk, reset, FlushE, ImmExtD, ImmExtE);
    floprc #(32) pc4_pipe   (clk, reset, FlushE, PCPlus4D, PCPlus4E);

    //Execute Stage
    ex_stage execute(ALUSrcE, JumpE, BranchE, ForwardAE, ForwardBE, ALUControlE, RD1E, RD2E, PCE, ImmExtE, ResultW, ALUResultM, PCSrcE, ALUResultE, WriteDataE, PCTargetE);
    
    flopr #(101) ex_to_mem(clk, reset, {ALUResultE, WriteDataE, RdE, PCPlus4E}, {ALUResultM, WriteDataM, RdM, PCPlus4M});
    
    //Memory Stage
    mem_stage memory(clk, MemWriteM, ALUResultM, WriteDataM, ReadDataM);
    
    flopr #(101) mem_to_wb(clk, reset, {ALUResultM, ReadDataM, RdM, PCPlus4M}, {ALUResultW, ReadDataW, RdW, PCPlus4W});
    
    //Writeback Stage
    wb_stage writeback(ResultSrcW, ReadDataW, ALUResultW, PCPlus4W, ResultW);


//Control Signlas Routing
controller control_unit(InstrD[6:0], InstrD[14:12], InstrD[30], ResultSrcD, MemWriteD, ALUSrcD, RegWriteD, JumpD, BranchD, ImmSrcD, ALUControlD);
floprc #(10) id_to_ex_control(clk, reset, FlushE, {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD, ALUControlD, ALUSrcD}, {RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE});
flopr #(4) ex_to_mem_control(clk, reset, {RegWriteE,ResultSrcE, MemWriteE}, {RegWriteM, ResultSrcM, MemWriteM});
flopr #(3) mem_to_wb_control(clk, reset, {RegWriteM, ResultSrcM}, {RegWriteW, ResultSrcW});

//Hazard Unit
HazardUnit hazard_unit(RegWriteM, RegWriteW, ResultSrcE[0], PCSrcE, Rs1E, Rs2E, InstrD[19:15], InstrD[24:20], RdM, RdW, RdE, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);

endmodule
