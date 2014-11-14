module testbench04;
  reg [3:0]A, B;
  reg C0;
  wire [3:0]S;
  wire C4;
  _4bit_Adder_df mod(S, C4, A, B, C0);
  initial
    begin
      $monitor($time, " A=%4b, B=%4b, C=%b, Carry=%b, Sum=%4b.", A, B, C0, C4, S);
      #0  A=4'b0000; B=4'b0000; C0=1'b0;
      #10 A=4'b1000; B=4'b0101; C0=1'b1;
      #10 A=4'b1111; B=4'b1000; C0=1'b1;
      #10 $finish;
    end
endmodule