module signa(neg,A); //this module is used to get the sign of an input 4-digit number
  input [3:0] A;
  output neg;
  reg neg;
  always @ (A)
  if (A[3] == 1)
    begin
      neg =1;
    end
  else
    neg =0;
endmodule