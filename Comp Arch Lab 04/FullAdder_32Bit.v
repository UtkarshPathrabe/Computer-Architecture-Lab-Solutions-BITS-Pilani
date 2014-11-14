module DECODER(out, x, y, z);
  input x, y, z;
  output  [0:7]out;
  wire  x0, y0, z0;
  not g1(x0, x);
  not g2(y0, y);
  not g3(z0, z);
  and g4(out[0], x0, y0, z0);
  and g5(out[1], x0, y0, z);
  and g6(out[2], x0, y, z0);
  and g7(out[3], x0, y, z);
  and g8(out[4], x, y0, z0);
  and g9(out[5], x, y0, z);
  and g10(out[6], x, y, z0);
  and g11(out[7], x, y, z);
endmodule

module  FADDER(carry, sum, x, y, z);
  input x, y, z;
  output  sum, carry;
  wire  [0:7] d; 
  DECODER dec(d, x, y, z);
  assign  sum = d[1] | d[2] | d[4] | d[7],
          carry = d[3] | d[5] | d[6] | d[7];
endmodule

module FADDER8(carry, sum, A, B, CarryIn);
  input [7:0] A, B;
  input CarryIn;
  output  [7:0]sum;
  output  carry;
  wire  c1, c2, c3, c4, c5, c6, c7;
  FADDER  mod1(c1, sum[0], A[0], B[0], CarryIn);
  FADDER  mod2(c2, sum[1], A[1], B[1], c1);
  FADDER  mod3(c3, sum[2], A[2], B[2], c2);
  FADDER  mod4(c4, sum[3], A[3], B[3], c3);
  FADDER  mod5(c5, sum[4], A[4], B[4], c4);
  FADDER  mod6(c6, sum[5], A[5], B[5], c5);
  FADDER  mod7(c7, sum[6], A[6], B[6], c6);
  FADDER  mod8(carry, sum[7], A[7], B[7], c7);
endmodule

module FADDER32(carry, sum, A, B, CarryIn);
  input [31:0] A, B;
  input CarryIn;
  output  [31:0]sum;
  output  carry;
  wire  c1, c2, c3; 
  FADDER8  mod1(c1, sum[7:0], A[7:0], B[7:0], CarryIn);
  FADDER8  mod2(c2, sum[15:8], A[15:8], B[15:8], c1);
  FADDER8  mod3(c3, sum[23:16], A[23:16], B[23:16], c2);
  FADDER8  mod4(carry, sum[31:24], A[31:24], B[31:24], c3);
endmodule

module testbench_32BFA;
  reg [31:0] A, B;
  reg CarryIn;
  wire  [31:0]Sum;
  wire  Carry;
  integer i, j;
  FADDER32 mod(Carry, Sum, A, B, CarryIn);
  initial
    begin
      $monitor($time," A = %b, B = %b, Carry In = %b, Carry = %b, Sum = %b.", A, B, CarryIn, Carry, Sum);
      #0 A=32'b11110000000000000000000000000000; B=32'b00000000000000000000000000000111; CarryIn=1'b0;
      #5 A=32'b11111111111111111111111111111111; B=32'b11111111111111111111111111111111; CarryIn=1'b0;
      #5 A=32'b11110000000000001111000000000000; B=32'b00001010101000000000000000000111; CarryIn=1'b1;
    end
endmodule