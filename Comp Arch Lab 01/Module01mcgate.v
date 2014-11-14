module magComp_gate(ALTB, AGTB, AEQB, A, B);
  input [3:0] A, B;
  output ALTB, AGTB, AEQB;
  wire [3:0]X, Y, Z, NotA, NotB;
  
  xnor 
      g01(X[3], A[3], B[3]),
      g02(X[2], A[2], B[2]),
      g03(X[1], A[1], B[1]),
      g04(X[0], A[0], B[0]);
  not 
      g05(NotA[3], A[3]),
      g06(NotA[2], A[2]),
      g07(NotA[1], A[1]),
      g08(NotA[0], A[0]),
      g09(NotB[3], B[3]),
      g10(NotB[2], B[2]),
      g11(NotB[1], B[1]),
      g12(NotB[0], B[0]);
  and
      g13(Y[0], A[3], NotB[3]),
      g14(Y[1], X[3], A[2], NotB[2]),
      g15(Y[2], X[3], X[2], A[1], NotB[1]),
      g16(Y[3], X[3], X[2], X[1], A[0], NotB[0]);
  and
      g17(Z[0], NotA[3], B[3]),
      g18(Z[1], X[3], NotA[2], B[2]),
      g19(Z[2], X[3], X[2], NotA[1], B[1]),
      g20(Z[3], X[3], X[2], X[1], NotA[0], B[0]);
      
  and g21(AEQB, X[3], X[2], X[1], X[0]);
  or  
      g22(ALTB, Z[0], Z[1], Z[2], Z[3]),
      g23(AGTB, Y[0], Y[1], Y[2], Y[3]);
endmodule
