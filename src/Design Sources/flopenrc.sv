`timescale 1ns / 1ps


module flopenrc #(parameter WIDTH=8)(
                 input  logic             clk, reset, en,clr,
                 input  logic [WIDTH-1:0] d,
                 output logic [WIDTH-1:0] q
                );
                
always_ff @(posedge clk, posedge reset)
    if(reset)     q<=0;
    else if(clr)  q<=0;
    else if(~en)  q<=d;//active low enabled              
                
endmodule