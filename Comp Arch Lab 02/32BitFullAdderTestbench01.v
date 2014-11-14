module testbench_32BFA;
  reg [31:0] A, B;
  reg CarryIn;
  wire  [31:0]Sum;
  wire  Carry;
  integer i, j;
  FADDER32 mod(Sum, Carry, A, B, CarryIn);
  initial
    begin
      $monitor($time," A = %b, B = %b, Carry In = %b, Carry = %b, Sum = %b.", A, B, CarryIn, Carry, Sum);
      #0 A=32'b11110000000000000000000000000000; B=32'b00000000000000000000000000000111; CarryIn=1'b0;
      #5 A=32'b11111111111111111111111111111111; B=32'b11111111111111111111111111111111; CarryIn=1'b0;
      #5 A=32'b11110000000000001111000000000000; B=32'b00001010101000000000000000000111; CarryIn=1'b1;
    end
endmodule