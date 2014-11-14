module FADDER32(sum, carry, A, B, CarryIn);
  input [31:0] A, B;
  input CarryIn;
  output  [31:0]sum;
  output  carry;
  wire  c1, c2, c3;
  
  FADDER8  mod1(sum[7:0], c1, A[7:0], B[7:0], CarryIn);
  FADDER8  mod2(sum[15:8], c2, A[15:8], B[15:8], c1);
  FADDER8  mod3(sum[23:16], c3, A[23:16], B[23:16], c2);
  FADDER8  mod4(sum[31:24], carry, A[31:24], B[31:24], c3);
endmodule