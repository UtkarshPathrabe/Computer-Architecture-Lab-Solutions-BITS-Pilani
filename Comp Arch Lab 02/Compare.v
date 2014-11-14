module compar(A,B,signA,signB,CMP1,CMP2,CMP3); //This module implement the compare code for input of two 3-digit numbers using signa().
  input [3:0] A;
  input [3:0] B;
  output signA,signB,CMP1,CMP2,CMP3;
  reg CMP1,CMP2,CMP3;
  signa forA(signA,A);
  signa forB(signB,B);
  always @ (A or B or signA or signB)// performs check for four different cases
  if(signA==1 && signB==0)
    begin
      CMP1 = 0;
      CMP2 = 0;
      CMP3 = 1;
    end
  else if(signA==0 && signB==1)
    begin
      CMP1 = 1;
      CMP2 = 0;
      CMP3 = 0;
    end
  else if (A > B )
    begin
      CMP1 = 1;
      CMP2 = 0;
      CMP3 = 0;
    end
  else if (A == B)
    begin
      CMP1 = 0;
      CMP2 = 1;
      CMP3 = 0;
    end
  else
    begin
      CMP1 = 0;
      CMP2 = 0;
      CMP3 = 1;
    end
endmodule