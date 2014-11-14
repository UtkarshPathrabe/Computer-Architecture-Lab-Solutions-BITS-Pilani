module mux2to1_df(Out, A, B, select);
  input A, B, select;
  output Out;
  assign Out = select ? A : B;
endmodule
