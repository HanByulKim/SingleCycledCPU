`timescale 1ns / 1ps
`define WORD_SIZE 16
module ALU(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    input [3:0] OP,
    output reg [15:0] C,
    output reg Cout,
    output reg [`WORD_SIZE-1:0] output_port
    );
    initial begin Cout = 1'b0; end
    
    always @* begin
      case(OP)
      4'b0000: begin 
        {Cout,C} = A + B + Cin; //add //addi
      end
      4'b0001: C = {B,8'b00000000}; //LHI
      4'b0010: begin C = A; output_port = A; end //WWD
      endcase
    end
    
endmodule
