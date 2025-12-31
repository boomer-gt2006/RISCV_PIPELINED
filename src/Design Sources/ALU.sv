`timescale 1ns / 1ps


module ALU(input  logic [31:0] A, B, 
           input  logic  [2:0] ALUControl,
           output logic [31:0] ALUResult,
           output logic        Zero

    );
always_comb    
    case(ALUControl)
        3'b000:ALUResult = A+B;//addition, addi
        3'b001:ALUResult = A-B;//subtraction
        3'b010:ALUResult = A&B;//and
        3'b011:ALUResult = A|B;//or
        3'b101:ALUResult = (A<B)?32'd1:32'd0;
        default: ALUResult = 32'd0;
        
        endcase

assign Zero = (ALUResult==32'd0);

    
endmodule
