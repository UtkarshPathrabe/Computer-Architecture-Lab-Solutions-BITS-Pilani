module SCDataPath(ALUOutput, PCCurrent, PC, reset, clock);
  input clock, reset;
  input [31:0]  PC;
  output  [31:0]  ALUOutput, PCCurrent;
  wire  [31:0]  Instruction;
  wire  [31:0]  PCNew1, PCNew2;
  reg [31:0]  PCCurrent;
  wire  RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
  wire  [1:0] ALUOp;
  wire  [2:0] Op;
  wire  [4:0] MuxRegWriteAddress;
  wire  [31:0]  MuxALU2Src, MuxWriteDataSrc, MuxJumpOut, DataMemOut;
  wire  [31:0]  ReadData1, ReadData2, SignExtend, ShiftLeft, ShiftLeft2, AdderOut, JumpAddress, BranchAddress;
  wire  Zero, BranchDest, CarryOut, Carry1, Carry2;
  
  Instruction_Memory  unit01(Instruction, PC, clock);     //Read the instruction at positive edge of clock
  FADDER32  unit02(Carry1, PCNew1, PC, 32'h4, 0);         //PC = PC + 4
  Sign_Extender unit03(SignExtend, Instruction[15:0]);    //Sign Extend the Branch Offset
  Shift_Left  unit04(ShiftLeft, SignExtend);              //Shift left by 2 bits the Sign Extended Branch Offset
  Shift_Left  unit05(ShiftLeft2, Instruction[25:0]);      //Shift left by 2 bits the Jump Offset
  concatJuPC  unit06(JumpAddress, ShiftLeft2, PCNew1);    //Concat PC and Left Shifted Jump Offset 
  MainControlUnit unit07(RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[0], ALUOp[1], Instruction[31:26]);  //Generate the Control Signals
  MUX5Bit_2To1  unit08(MuxRegWriteAddress, RegDst, Instruction[20:16], Instruction[15:11]);                                             //Selecting the writing register
  RegFile_32  unit09(ReadData1, ReadData2, clock, reset, 1'b0, Instruction[25:21], Instruction[20:16], MuxRegWriteAddress, MuxWriteDataSrc);  //Reading from the register file
  ALUControlUnit  unit10(Op, Instruction[5:0], ALUOp);    //Generating the ALU Control Signals
  Mux32Bit_2To1 unit11(MuxALU2Src, ALUSrc, ReadData2, SignExtend);              //Selecting the second ALU Source
  ALU32Bit  unit12(Zero, CarryOut, ALUOutput, ReadData1, MuxALU2Src, Op);       //Doing the ALU Operation
  FADDER32  unit13(Carry2, PCNew2, PCNew1, ShiftLeft, 0); //Generating the Branch Address
  and unit14(BranchDest, Branch, Zero);                   //Generating the signal whether to branch or not
  Mux32Bit_2To1 unit15(BranchAddress, BranchDest, PCNew1, PCNew2);              //Generating the new address after the branch MUX
  Mux32Bit_2To1 unit16(MuxJumpOut, Jump, BranchAddress, JumpAddress);           //Generating the new address after the Jump MUX
  Data_Memory unit17(clock, MemRead, ALUOutput, DataMemOut, MemWrite, ALUOutput, ReadData2);      //Operating on Data memory
  Mux32Bit_2To1 unit18(MuxWriteDataSrc, MemToReg, ALUOutput, DataMemOut);       //Writing back to register file
  RegFile_32  unit19(ReadData1, ReadData2, clock, reset, RegWrite, Instruction[25:21], Instruction[20:16], MuxRegWriteAddress, MuxWriteDataSrc);  //Writing to the register file
  initial begin
    PCCurrent = PC;
  end
  always @(negedge clock) begin
    PCCurrent = MuxJumpOut;
  end
endmodule

module TBSCDataPath;
  reg clock, reset;
  reg [31:0]  PC;
  wire  [31:0]  ALUOutput, PCCurrent;
  SCDataPath  SCDP(ALUOutput, PCCurrent, PC, reset, clock);
  initial begin
    $monitor($time, " :PC = %b, Reset = %b, Clock = %b, NextPC = %b, ALUOutput = %b.", PC, reset, clock, PCCurrent, ALUOutput);
    #0  clock = 1'b0; PC = 32'd20; reset = 1'b0;
    #15 reset = 1'b1;
    #10 PC = 32'd12;
    #40 PC = PCCurrent;
    #40 PC = PCCurrent;
    #50 $finish;
  end
  always  begin
    #10 clock = ~clock;
  end
endmodule