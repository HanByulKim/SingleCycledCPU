`timescale 1ns / 1ps

module ALUctrl(
    input ALUOp,
    input [3:0] OP,
    input [5:0] function_code,
    output reg [3:0] ctrl
    );
    always @(*) begin
        case(OP)
            4'd15: begin
                if(function_code == 6'd0) ctrl = 4'b0000;
                else if(function_code == 6'd28) ctrl = 4'b0010;
            end
            4'd4: ctrl = 4'b0000;
            4'd6: ctrl = 4'b0001;        endcase
    end
    
endmodule
