module FADDER(sum, carry, x, y, z);
  input x, y, z;
  output  sum, carry;
  wire  [0:7]d;
  
  DECODER dec(d, x, y, z);
  assign  sum = d[1] | d[2] | d[4] | d[7],
          carry = d[3] | d[5] | d[6] | d[7];
endmodule