module mux2to1_beh(Out, A, B, select);
  input A, B, select;
  output Out;
  reg Out;
  always@(A or B or select)
  if(select==1)
    Out = A;
  else
    Out = B;
endmodule
