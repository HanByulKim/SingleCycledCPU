`include "opcodes.v"

module Control_unit (
  input [3:0] instruction,
  input [5:0] function_code,
  output reg RegDst,
  output reg Jump,
  output reg Branch,
  output reg MemRead,
  output reg MemtoReg,
  output reg ALUOp,
  output reg MemWrite,
  output reg ALUSrc,
  output reg RegWrite,
  output reg IsWWD
);
  

  // ... fill in the rest of the code

always@(*) begin
  case(instruction)
  4'd15: begin
    if(function_code == `FUNC_ADD) begin  //add
      RegDst=1;
      Jump=0;
      Branch=0;
      MemRead=0;
      MemtoReg=0;
      ALUOp=1;
      MemWrite=0;
      ALUSrc=0;
      RegWrite=1;
      IsWWD=0;
    end
    else if(function_code == `FUNC_WWD) begin  //wwd
      RegDst=0;
      Jump=0;
      Branch=0;
      MemRead=0;
      MemtoReg=0;
      ALUOp=0;
      MemWrite=0;
      ALUSrc=0;
      RegWrite=0;
      IsWWD=1;
    end
  end
  4'd4: begin //adi
    RegDst=0;
    Jump=0;
    Branch=0;
    MemRead=0;
    MemtoReg=0;
    ALUOp=1;
    MemWrite=0;
    ALUSrc=1;
    RegWrite=1;
          IsWWD=0;
  end
  4'd6: begin //lhi  
      RegDst=0;
      Jump=0;
      Branch=0;
      MemRead=0;
      MemtoReg=0;
      ALUOp=1;
      MemWrite=0;
      ALUSrc=1;
      RegWrite=1;
      IsWWD=0;
  end
  4'd9: begin //lhi  
        RegDst=0;
        Jump=1;
        Branch=0;
        MemRead=0;
        MemtoReg=0;
        ALUOp=0;
        MemWrite=0;
        ALUSrc=0;
        RegWrite=0;
        IsWWD=0;
    end
  endcase
end

endmodule