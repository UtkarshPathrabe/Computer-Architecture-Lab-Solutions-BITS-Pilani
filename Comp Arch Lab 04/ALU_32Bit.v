module  ALU32Bit(CarryOut, Result, A, B, Op, BiInvert);
  output  [31:0]  Result;
  output  CarryOut;
  input [31:0]  A, B;
  input [1:0] Op;
  input BiInvert;
  wire  [31:0]  wAnd, wOr, wAdd, wMux, notB;
  assign  {notB} = ~B;
  AND32Bit  And(wAnd, A, B);
  OR32Bit Or(wOr, A, B);
  Mux32Bit_2To1 Mux1(wMux, BiInvert, B, notB);
  FADDER32  Add(CarryOut, wAdd, A, wMux, BiInvert);
  Mux32Bit_4To1 Mux2(Result, Op, wAnd, wOr, wAdd, 32'h00000000);
endmodule

module  ALUTestBench;
  reg BiInvert;
  reg [1:0] Op;
  reg [31:0] A,B;
  wire  [31:0] Result;
  wire  CarryOut;
  ALU32Bit  ALU(CarryOut, Result, A, B, Op, BiInvert);
  initial begin
    $monitor($time, " :A = %b,\n\t B = %b,\n\t Operartion = %b,\n\t BiInvert = %b,\n\t Result = %b,\n\t Carry Out = %b.", A, B, Op, BiInvert, Result, CarryOut);
    #0  A = 32'ha5a5a5a5; B = 32'h5a5a5a5a; Op = 2'b00; BiInvert = 1'b0; //must perform AND resulting in zero
    #100  Op = 2'b01;       //OR
    #100  Op = 2'b10;       //ADD
    #100  BiInvert = 1'b1;  //SUB
    #200  $finish;
  end
endmodule