`timescale 1ns / 1ps


module HazardUnit(input  logic        RegWriteM, RegWriteW, ResultSrcE0, PCSrcE,
                  input  logic [4:0]  Rs1E, Rs2E, Rs1D, Rs2D,
                  input  logic [4:0] RdM, RdW, RdE,
                  output logic        StallF, StallD, FlushD, FlushE,
                  output logic [1:0]  ForwardAE, ForwardBE 

    );
    
logic lwStall;

assign lwStall = ResultSrcE0 &&
                 (RdE != 5'd0) &&
                 ((Rs1D == RdE) || (Rs2D == RdE));

assign StallF=lwStall;
assign StallD=lwStall;


assign FlushD=PCSrcE;
assign FlushE=lwStall|PCSrcE;

always_comb
begin
    ForwardAE=2'b00;//No Forwarding

    if(((Rs1E==RdM)&&RegWriteM)&&(Rs1E!=0)) ForwardAE=2'b10;//Forward from Memory Stage
    
    else if(((Rs1E==RdW)&&RegWriteW)&&(Rs1E!=0)) ForwardAE=2'b01;//Forward from Writeback Stage
    
   

end

always_comb
begin
    ForwardBE=2'b00;//No Forwarding

    if(((Rs2E==RdM)&&RegWriteM)&&(Rs2E!=0)) ForwardBE=2'b10;//Forward from Memory Stage
    
    else if(((Rs2E==RdW)&&RegWriteW)&&(Rs2E!=0)) ForwardBE=2'b01;//Forward from Writeback Stage
    
    

end


endmodule
