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