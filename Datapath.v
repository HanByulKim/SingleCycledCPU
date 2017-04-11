`define WORD_SIZE 16    // data and address word size

module Datapath (
  output reg readM,                       // read from memory
  output reg [`WORD_SIZE-1:0] address,    // current address for data
  inout [`WORD_SIZE-1:0] data,        // data being input or output
  input inputReady,                   // indicates that data is ready from the input port
  input reset_n,                      // active-low RESET signal
  input clk,                          // clock signal

  // for debuging/testing purpose
  output reg [`WORD_SIZE-1:0] num_inst,   // number of instruction during execution
  output [`WORD_SIZE-1:0] output_port, // this will be used for a "WWD" instruction

  input RegDst,
  input Jump,
  input Branch,
  input MemRead,
  input MemtoReg,
  input ALUOp,
  input MemWrite,
  input ALUSrc,
  input RegWrite
);
reg [`WORD_SIZE-1:0] inst;
wire [`WORD_SIZE-1:0] A;
wire [`WORD_SIZE-1:0] B;
wire [`WORD_SIZE-1:0] Btemp;

wire [1:0] addr1;
wire [1:0] addr2;
wire [1:0] addr3;
wire [3:0] ctrl; //alu ctrl

wire [`WORD_SIZE-1:0] C;
wire [`WORD_SIZE-1:0] Cout; // alu output
wire [`WORD_SIZE-1:0] wdatareg;
wire [`WORD_SIZE-1:0] rdatamem;

wire [15:0] imm;

assign addr1=inst[11:10];
assign addr2=inst[9:8];
assign addr3=(RegDst == 1) ? inst[7:6] : inst[9:8];
assign imm = (inst[7] == 1) ? {8'b11111111,inst[7:0]} : {8'b00000000,inst[7:0]};
assign B=(ALUSrc==1) ? imm : Btemp; // ALUSrc
assign wdatareg=(MemtoReg == 1) ? rdatamem : C;

ALUctrl aluctrl(.ALUOp(ALUOp), .OP(inst[15:12]), .function_code(inst[5:0]), .ctrl(ctrl));
ALU alu(.A(A), .B(B), .Cin(1'b0), .OP(ctrl), .C(C), .Cout(Cout), .output_port(output_port));

Register register(.clk(clk), .write(RegWrite), .addr1(addr1), .addr2(addr2), .addr3(addr3), .data3(wdatareg), .data1(A), .data2(Btemp));
  // ... fill in the rest of the code

always@(posedge clk or negedge reset_n) begin
  if(reset_n == 1'b0) begin
    num_inst<=0;
    readM<=0;
    address<=-1;
  end
  else begin
    num_inst <= num_inst + 1;
    if(Jump == 1) begin
        address = {inst[15:12],imm};
    end
    else address = address + 1;
    readM<=1;
  end
end
always@(inputReady) begin
    if(inputReady == 1) begin
        readM<=0;
        inst<=data;
    end
end

endmodule