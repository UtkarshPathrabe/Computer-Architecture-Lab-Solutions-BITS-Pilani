module testbench; //This module tests the functionality of compare() module
  reg Input,Clk;
  wire Out;
  reg [3:0] A;
  wire a,b,c,OutA,OutB,signA,signB,CMP1,CMP2,CMP3;
  reg [3:0] B;
  initial
    begin
      A=4'b0000;//input1
      B=4'b0000;//input2
    end
  initial
    begin
      #1 A=-8;B=-5;
      #1 A=2; B=7;
      #1 A=5; B=-1;
    end
  compar c1(A,B,signA,signB,CMP1,CMP2,CMP3); //make an instance of compar()
  initial
    begin
      $monitor($time,"A=%b, B=%b AgrB=%b, AeqB=%b, AltB=%b",A,B,CMP1,CMP2,CMP3);
    end
  initial
    begin
      #5 $finish;
    end
endmodule