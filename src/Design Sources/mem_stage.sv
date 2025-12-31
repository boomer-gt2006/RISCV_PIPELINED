`timescale 1ns / 1ps


module mem_stage(input  logic clk, MemWriteM, 
                 input  logic [31:0] ALUResultM, WriteDataM,
                 output logic [31:0] ReadDataM 

    );

//Instanciating Data Memory    
dmem dmem(clk, MemWriteM, ALUResultM, WriteDataM, ReadDataM);
    
    
endmodule
