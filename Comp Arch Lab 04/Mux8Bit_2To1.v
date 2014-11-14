module  Mux8Bit_2To1(out, select, in1, in2);
  input [7:0] in1, in2;
  input select;
  output  [7:0] out;
  Mux2To1 m0(out[0], select, in1[0], in2[0]);
  Mux2To1 m1(out[1], select, in1[1], in2[1]);
  Mux2To1 m2(out[2], select, in1[2], in2[2]);
  Mux2To1 m3(out[3], select, in1[3], in2[3]);
  Mux2To1 m4(out[4], select, in1[4], in2[4]);
  Mux2To1 m5(out[5], select, in1[5], in2[5]);
  Mux2To1 m6(out[6], select, in1[6], in2[6]);
  Mux2To1 m7(out[7], select, in1[7], in2[7]);
endmodule

module  TestBench_Mux8Bit;
  reg [7:0] in1, in2;
  reg select;
  wire  [7:0] out;
  Mux8Bit_2To1  Mux(out, select, in1, in2);
  initial begin
    $monitor($time, " Input1 = %b, Input2 = %b, Select = %b, Output = %b.", in1, in2, select, out);
    #0  in1 = 8'b10101010;  in2 = 8'b01010101;  select = 1'b0;
    #100  select  = 1'b1;
    #200  $finish;
  end
endmodule

module  Mux8Bit_2To1_generate(out, select, in1, in2);
  input [7:0] in1, in2;
  input select;
  output  [7:0] out;
  genvar  j;
  generate  for(j = 0; j < 8; j = j + 1)  
    begin:  mux_loop
      Mux2To1 Mux(out[j], select, in1[j], in2[j]);
    end
  endgenerate
endmodule

module  TestBench_Mux8Bit_generate;
  reg [7:0] in1, in2;
  reg select;
  wire  [7:0] out;
  Mux8Bit_2To1_generate  Mux(out, select, in1, in2);
  initial begin
    $monitor($time, " Input1 = %b, Input2 = %b, Select = %b, Output = %b.", in1, in2, select, out);
    #0  in1 = 8'b10101010;  in2 = 8'b01010101;  select = 1'b0;
    #100  select  = 1'b1;
    #200  $finish;
  end
endmodule