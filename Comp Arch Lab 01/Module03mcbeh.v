module magComp_beh(ALTB, AGTB, AEQB, A, B);
  input [3:0] A, B;
  output ALTB, AGTB, AEQB;
  reg ALTB, AGTB, AEQB;
  always@(A or B)
    begin
      if(A==B) begin
        ALTB=0;
        AGTB=0;
        AEQB=1;
      end else if(A > B) begin
        ALTB=0;
        AGTB=1;
        AEQB=0;
      end else begin
        ALTB=1;
        AGTB=0;
        AEQB=0;
      end
    end
endmodule
