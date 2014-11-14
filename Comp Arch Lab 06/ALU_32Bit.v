module  ALU32Bit(Zero, CarryOut, Result, A, B, Op);
  input [2:0] Op;
  input [31:0] A, B;
  output [31:0] Result;
  reg [31:0] Result;
  output CarryOut, Zero;
  reg CarryOut;
  assign Zero = (({Result} == 0)) ? 1 : 0;
  always @ (Op, A, B) begin
    case(Op)
      0:  Result <= A & B;
      1:  Result <= A | B;
      2:  {CarryOut, Result[31:0]} <= A + B;
      6:  {CarryOut, Result[31:0]} <= A - B;
      7:  Result <= A < B ? 1 : 0;
      default: Result <= 0;
    endcase
  end
endmodule

module  ALUTestBench;
  reg [2:0] Op;
  reg [31:0] A, B;
  wire  [31:0] Result;
  wire  CarryOut, Zero;
  ALU32Bit  ALU(Zero, CarryOut, Result, A, B, Op);
  initial begin
    $monitor($time, " :A = %b,\n\t B = %b,\n\t Operartion = %b,\n\t Result = %b,\n\t Carry Out = %b,\n\t Zero = %b.", A, B, Op, Result, CarryOut, Zero);
    #0  A = 32'ha5a5a5a5; B = 32'h5a5a5a5a; Op = 3'b000; //must perform AND resulting in zero
    #100  Op = 3'b001;        //OR
    #100  Op = 3'b010;        //ADD
    #100  Op = 3'b110;        //SUB
    #100  A = 32'ha5a5a5a5; B = 32'ha5a5a5a5; Op = 3'b110;    //Check for zero
    #100  B = 32'ha5a5a5a5; A = 32'h5a5a5a5a; Op = 3'b111;    //SLT
    #200  $finish;
  end
endmodule