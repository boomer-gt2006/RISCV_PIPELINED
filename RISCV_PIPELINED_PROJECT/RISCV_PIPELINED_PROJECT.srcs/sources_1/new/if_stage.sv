`timescale 1ns / 1ps


module if_stage(input  logic clk, reset, PCSrcE, stallF,
                input  logic [31:0] PCTargetE,
                output logic [31:0] PCPlus4F, InstrF, PCF

    );
    
logic [31:0] PCNext;

//next PC logic
adder pcadd4(PCF, 32'd4, PCPlus4F);
flopenr #(32) pcreg(clk, reset,stallF, PCNext, PCF); 
mux2 #(32) pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNext);

//fetching instruction
imem imem(PCF, InstrF);

endmodule
