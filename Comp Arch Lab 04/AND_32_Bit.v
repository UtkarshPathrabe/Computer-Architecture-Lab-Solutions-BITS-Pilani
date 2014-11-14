module  AND32Bit(out, in1, in2);
  input [31:0]  in1, in2;
  output  [31:0]  out;
  assign  {out} = in1 & in2;
endmodule

module  AND32TestBench;
  reg [31:0]  in1, in2;
  wire  [31:0]  out;
  AND32Bit  ANDGate(out, in1, in2);
  initial begin
    $monitor($time, " Input1 = %b, Input2 = %b, Output = %b.", in1, in2, out);
    #0  in1 =  32'hA5A5;  in2 = 32'h5A5A;
    #100  in1 = 32'h5A5A;
    #200  $finish;
  end
endmodule