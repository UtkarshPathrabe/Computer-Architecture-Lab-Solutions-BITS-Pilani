module mux4To1_gate(out, in, select);
  input [0:3]in;
  input [0:1]select;
  output  out;
  wire  [0:1]nselect;
  wire  a1, a2, a3, a4;
  
  not g1(nselect[0], select[0]);
  not g2(nselect[1], select[1]);
  
  and g3(a1, in[0], nselect[0], nselect[1]);
  and g4(a2, in[1], nselect[0], select[1]);
  and g5(a3, in[2], select[0], nselect[1]);
  and g6(a4, in[3], select[0], select[1]);
  
  or  g7(out, a1, a2, a3, a4);
endmodule