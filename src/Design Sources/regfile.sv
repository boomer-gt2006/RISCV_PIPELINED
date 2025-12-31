`timescale 1ns / 1ps


module regfile(input  logic       clk, we3,
               input  logic [4:0] A1, A2, A3,
               input  logic [31:0] WD3,
               output logic [31:0] RD1, RD2

    );
    
logic [31:0] RAM[0:31];

assign RD1=(A1==5'd0)?32'd0:RAM[A1];
assign RD2=(A2==5'd0)?32'd0:RAM[A2];


always_ff @(negedge clk)//negative edge triggered to write the data in the second half of the clock cycle
    if(we3 && A3!=5'd0) RAM[A3]<=WD3;
    



endmodule
