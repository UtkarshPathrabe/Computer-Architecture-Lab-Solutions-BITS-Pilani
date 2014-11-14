module concatJuPC(out, J, PC);
  input [31:0] J, PC;
  output [31:0] out;
  assign {out} = {{PC[31:28]}, {J[27:0]}};
endmodule

module TBconcat;
  reg [31:0] J, PC;
  wire [31:0] out;
  concatJuPC con(out, J, PC);
  initial begin
    $monitor($time, " PC = %b, JumpAddress = %b, Output = %b.", PC, J, out);
    #0  PC = 32'hFFFFFFFF; J = 32'h88000000;
    #20 PC = 32'h98765432; J = 32'h23456789;
    #100 $finish;
  end
endmodule