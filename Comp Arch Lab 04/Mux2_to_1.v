module Mux2To1(out, select, in1, in2);
  input in1, in2, select;
  output  out;
  wire  not_select, a1, a2;
  not g1(not_select, select);
  and g2(a1, in1, not_select);
  and g3(a2, in2, select);
  or  g4(out, a1, a2);
endmodule