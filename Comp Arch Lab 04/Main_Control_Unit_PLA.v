module  MainControlUnit(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1, Op);
  output  RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1;
  input [5:0] Op;
  wire  RFormat, LW, SW, BEQ;
  assign  RFormat = (~Op[5])&(~Op[4])&(~Op[3])&(~Op[2])&(~Op[1])&(~Op[0]);
  assign  LW = (Op[5])&(~Op[4])&(~Op[3])&(~Op[2])&(Op[1])&(Op[0]);
  assign  SW = (Op[5])&(~Op[4])&(Op[3])&(~Op[2])&(Op[1])&(Op[0]);
  assign  BEQ = (~Op[5])&(~Op[4])&(~Op[3])&(Op[2])&(~Op[1])&(~Op[0]);
  assign  RegDst = RFormat;
  assign  ALUSrc = LW | SW;
  assign  MemToReg = LW;
  assign  RegWrite = RFormat | LW;
  assign  MemRead = LW;
  assign  MemWrite = SW;
  assign  Branch = BEQ;
  assign  ALUOp0 = RFormat;
  assign  ALUOp1 = BEQ;
endmodule

module MainControlTB;
  reg [5:0] Op;
  wire  RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1;
  MainControlUnit MCU(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1, Op);
  initial begin
    $monitor($time, " Op[5] = %b, Op[4] = %b, Op[3] = %b, Op[2] = %b, Op[1] = %b, Op[0] = %b, RegDst = %b, ALUSrc = %b, MemToReg = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, ALUOp0 = %b, ALUOp1 = %b.", Op[5], Op[4], Op[3], Op[2], Op[1], Op[0], RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp0, ALUOp1);
    #0  Op[5] = 1'b0; Op[4] = 1'b0; Op[3] = 1'b0; Op[2] = 1'b0; Op[1] = 1'b0; Op[0] = 1'b0;
    #100  Op[5] = 1'b1; Op[4] = 1'b0; Op[3] = 1'b0; Op[2] = 1'b0; Op[1] = 1'b1; Op[0] = 1'b1;
    #100  Op[5] = 1'b1; Op[4] = 1'b0; Op[3] = 1'b1; Op[2] = 1'b0; Op[1] = 1'b1; Op[0] = 1'b1;
    #100  Op[5] = 1'b0; Op[4] = 1'b0; Op[3] = 1'b0; Op[2] = 1'b1; Op[1] = 1'b0; Op[0] = 1'b0;
    #100  $finish;
  end
endmodule