module ENCODER(OpCode, FuncCode);
  input [7:0] FuncCode;
  output  [2:0] OpCode;
  reg [2:0] OpCode;
  always  @ (FuncCode)  begin
    if  (FuncCode[7])
      OpCode = 3'd0;
    else if  (FuncCode[6])
      OpCode = 3'd1;
    else if  (FuncCode[5])
      OpCode = 3'd2;
    else if  (FuncCode[4])
      OpCode = 3'd3;
    else if  (FuncCode[3])
      OpCode = 3'd4;
    else if  (FuncCode[2])
      OpCode = 3'd5;
    else if  (FuncCode[1])
      OpCode = 3'd6;
    else if  (FuncCode[0])
      OpCode = 3'd7;
    else
      OpCode = 3'bZZZ;
  end
endmodule

module ALU(Carry, X, A, B, OpCode);
  input [2:0] OpCode;
  input [3:0] A, B;
  output  [3:0] X;
  output  Carry;
  assign  {Carry, X} = (OpCode == 3'b000) ? (A + B) : (OpCode == 3'b001)  ? (A - B) : (OpCode == 3'b010) ? (A ^ B) : (OpCode == 3'b011) ? (A | B) : (OpCode == 3'b100) ? (A & B) : (OpCode == 3'b101) ? (~(A | B)) : (OpCode == 3'b110) ? (~(A & B)) : (~(A ^ B));
endmodule

module PARITYGENERATOR(X, Out);
  input [3:0] X;
  output  Out;
  assign  Out = ~(X[0] ^ X[1] ^ X[2] ^ X[3]);
endmodule

module FIRSTPIPE(clock, OpCode, A, B, OpOut, AOut, BOut);
  input [2:0] OpCode;
  input [3:0] A, B;
  input clock;
  output  [2:0] OpOut;
  output  [3:0] AOut, BOut;
  reg [2:0] OpOut;
  reg [3:0] AOut, BOut;
  always  @ (posedge clock) begin
    OpOut <= OpCode;
    AOut  <= A;
    BOut  <= B;
  end
endmodule

module SECONDPIPE(clock, X, XOut);
  input clock;
  input [3:0] X;
  output  [3:0] XOut;
  reg [3:0] XOut;
  always  @ (posedge clock) begin
    XOut = X;
  end
endmodule

module DATAPATH(clock, FuncCode, A, B, Out);
  input clock;
  input [7:0] FuncCode;
  input [3:0] A, B;
  output  Out;
  wire  [2:0] OpCode, OpOut;
  wire  [3:0] AOut, BOut, X, XOut;
  wire  Carry;
  ENCODER mod1(OpCode, FuncCode);
  FIRSTPIPE mod2(clock, OpCode, A, B, OpOut, AOut, BOut);
  ALU mod3(Carry, X, AOut, BOut, OpOut);
  SECONDPIPE  mod4(clock, X, XOut);
  PARITYGENERATOR mod5(XOut, Out);
endmodule

module TESTBENCH;
  reg clock;
  reg [7:0] FuncCode;
  reg [3:0] A, B;
  wire  Out;
  DATAPATH  mod(clock, FuncCode, A, B, Out);
  initial begin
    $monitor($time, " A = %b, B = %b, Function Code = %b, OpCode = %b, AOut = %b, BOut = %b, OpOut = %b, X = %b, Carry = %b, XOut = %b, Output = %b.", A, B, FuncCode, mod.OpCode, mod.AOut, mod.BOut, mod.OpOut, mod.X, mod.Carry, mod.XOut, Out);
    #0  clock = 1'b1;
    #4  A = 4'b0101; B = 4'b1110;  FuncCode = 8'b10000000;
    #20 FuncCode = 8'b01000000;
    #20 FuncCode = 8'b00100000;
    #20 FuncCode = 8'b00010000;
    #20 FuncCode = 8'b00001000;
    #20 FuncCode = 8'b00000100;
    #20 FuncCode = 8'b00000010;
    #20 FuncCode = 8'b00000001;
    #50 $finish;
  end
  always
    #2  clock = ~clock;
endmodule