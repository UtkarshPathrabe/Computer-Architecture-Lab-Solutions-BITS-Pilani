module mux16To1_gate(out, in, select);
  input [0:15]in;
  input [0:3]select;
  output  out;
  wire  [0:3]w;
  
  mux4To1_gate  mux1(w[0], in[0:3], select[2:3]);
  mux4To1_gate  mux2(w[1], in[4:7], select[2:3]);
  mux4To1_gate  mux3(w[2], in[8:11], select[2:3]);
  mux4To1_gate  mux4(w[3], in[12:15], select[2:3]);
  mux4To1_gate  mux5(out, w[0:3], select[0:1]);
endmodule