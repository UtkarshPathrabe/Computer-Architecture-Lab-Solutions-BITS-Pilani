module FADDER8(sum, carry, A, B, CarryIn);
  input [7:0] A, B;
  input CarryIn;
  output  [7:0]sum;
  output  carry;
  wire  c1, c2, c3, c4, c5, c6, c7;
  
  FADDER  mod1(sum[0], c1, A[0], B[0], CarryIn);
  FADDER  mod2(sum[1], c2, A[1], B[1], c1);
  FADDER  mod3(sum[2], c3, A[2], B[2], c2);
  FADDER  mod4(sum[3], c4, A[3], B[3], c3);
  FADDER  mod5(sum[4], c5, A[4], B[4], c4);
  FADDER  mod6(sum[5], c6, A[5], B[5], c5);
  FADDER  mod7(sum[6], c7, A[6], B[6], c6);
  FADDER  mod8(sum[7], carry, A[7], B[7], c7);
endmodule