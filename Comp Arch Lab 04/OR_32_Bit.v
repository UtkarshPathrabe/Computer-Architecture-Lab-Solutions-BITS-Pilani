module  OR32Bit(out, in1, in2);
  input [31:0]  in1, in2;
  output  [31:0]  out;
  assign  {out} = in1 | in2;
endmodule

module  OR32TestBench;
  reg [31:0]  in1, in2;
  wire  [31:0]  out;
  OR32Bit  ORGate(out, in1, in2);
  initial begin
    $monitor($time, " Input1 = %b, Input2 = %b, Output = %b.", in1, in2, out);
    #0  in1 =  32'hA5A5;  in2 = 32'h5A5A;
    #100  in1 = 32'h5A5A;
    #200  $finish;
  end
endmodule