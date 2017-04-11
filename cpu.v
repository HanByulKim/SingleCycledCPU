///////////////////////////////////////////////////////////////////////////
// MODULE: CPU for TSC microcomputer: cpu.v
// Author: 
// Description: 

// DEFINITIONS
`define WORD_SIZE 16    // data and address word size

// INCLUDE files
`include "opcodes.v"    // "opcode.v" consists of "define" statements for
                        // the opcodes and function codes for all instructions

// MODULE DECLARATION
module cpu (
  output readM,                       // read from memory
  output [`WORD_SIZE-1:0] address,    // current address for data
  inout [`WORD_SIZE-1:0] data,        // data being input or output
  input inputReady,                   // indicates that data is ready from the input port
  input reset_n,                      // active-low RESET signal
  input clk,                          // clock signal

  // for debuging/testing purpose
  output wire[`WORD_SIZE-1:0] num_inst,   // number of instruction during execution
  output wire[`WORD_SIZE-1:0] output_port // this will be used for a "WWD" instruction
);

wire RegDst;
wire Jump;
wire Branch;
wire MemRead;
wire MemtoReg;
wire ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

  Datapath datapath(.readM(readM), .address(address), .data(data), .inputReady(inputReady), .reset_n(reset_n), .clk(clk), .num_inst(num_inst), .output_port(output_port), .RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
  Control_unit control(.instruction(data[15:12]), .function_code(data[7:0]), .RegDst(RegDst), .Jump(Jump), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
  // ... fill in the rest of the code

endmodule
//////////////////////////////////////////////////////////////////////////
