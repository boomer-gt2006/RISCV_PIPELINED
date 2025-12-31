`timescale 1ns / 1ps


module wb_stage(input  logic [1:0]  ResultSrcW,
                input  logic [31:0] ReadDataW, ALUResultW, PCPlus4W,
                output logic [31:0] ResultW

    );
    
mux3 #(32) wb_mux(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);
    
    
endmodule
