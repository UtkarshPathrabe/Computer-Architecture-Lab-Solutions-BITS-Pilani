module mux2to1_gate(Out, A, B, select);
  input A, B, select;
  output Out;
  wire c, d, e;
  
  not g1(e, select);
  and g2(c, A, select);
  and g3(d, B, e);
  or g4(Out, c, d);
endmodule
