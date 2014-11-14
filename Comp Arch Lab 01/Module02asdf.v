module fullAdder_df(S, C, x, y, z);
  input x, y, z;
  output S, C;
  assign  {C, S} = x + y + z;
endmodule

module _4bit_Adder_df(S, Cout, A, B, Cin);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;
  assign {Cout, S} = A + B + Cin;
endmodule

module _4bit_Adder_Sub_df(Sum, Carry, A, B, Select);
  input [3:0] A, B;
  input Select;
  output [3:0] Sum;
  output Carry;
  assign  {Carry, Sum} = A + (B^Select) + Select;
endmodule