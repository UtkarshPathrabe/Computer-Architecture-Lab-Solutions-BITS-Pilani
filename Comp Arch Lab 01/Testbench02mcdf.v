module testbench02;
  reg [3:0]A, B;
  wire ALTB, AGTB, AEQB;
  magComp_df mod(ALTB, AGTB, AEQB, A, B);
  initial
    begin
      $monitor($time, " A=%4b, B=%4b, ALTB=%b, AGTB=%b, AEQB=%b.", A, B, ALTB, AGTB, AEQB);
      #0  A=4'b1010; B=4'b1010;
      #10 A=4'b0101; B=4'b1010;
      #20 A=4'b1111; B=4'b1010;
      #30 $finish;
    end
endmodule
