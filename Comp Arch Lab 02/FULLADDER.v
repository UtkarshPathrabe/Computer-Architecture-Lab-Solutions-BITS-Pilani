module FULLADDER(Sum, Carry, A, B, C);
  input A, B, C;
  wire a;
  output  Sum, Carry;
  reg Sum, Carry;
  
  always@(A or B or C)
  {Carry, Sum} = A + B + C;
endmodule