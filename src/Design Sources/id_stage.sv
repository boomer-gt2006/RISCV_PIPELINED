`timescale 1ns / 1ps


module id_stage(input  logic        clk, RegWriteW,
                input  logic [31:0] InstrD,
                input  logic  [1:0] ImmSrcD,
                input  logic [31:0] ResultW,
                input  logic  [4:0] RdW,
                output logic [31:0] RD1D, RD2D, ImmExtD

    );
    
    
//Register File Instantiation   
regfile regfile(clk, RegWriteW, InstrD[19:15], InstrD[24:20], RdW, ResultW, RD1D, RD2D);

//Immediate Extension
extend extend(InstrD[31:7], ImmSrcD, ImmExtD);
    
    
endmodule
