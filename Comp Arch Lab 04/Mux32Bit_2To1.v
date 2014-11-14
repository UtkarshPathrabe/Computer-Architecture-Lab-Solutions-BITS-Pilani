module  Mux32Bit_2To1(out, select, in1, in2);
  input [31:0] in1, in2;
  input select;
  output  [31:0] out;
  Mux8Bit_2To1_generate Mux1(out[7:0], select, in1[7:0], in2[7:0]);
  Mux8Bit_2To1_generate Mux2(out[15:8], select, in1[15:8], in2[15:8]);
  Mux8Bit_2To1_generate Mux3(out[23:16], select, in1[23:16], in2[23:16]);
  Mux8Bit_2To1_generate Mux4(out[31:24], select, in1[31:24], in2[31:24]);
endmodule

module  TestBench_Mux32Bit;
  reg [31:0] in1, in2;
  reg select;
  wire  [31:0] out;
  Mux32Bit_2To1  Mux(out, select, in1, in2);
  initial begin
    $monitor($time, " Input1 = %b, Input2 = %b, Select = %b, Output = %b.", in1, in2, select, out);
    #0  in1 = 32'b10101010101010101010101010101010;  in2 = 32'b01010101010101010101010101010101;  select = 1'b0;
    #100  select  = 1'b1;
    #200  $finish;
  end
endmodule

module  Mux32Bit_4To1(out, select, in1, in2, in3, in4);
  input [31:0]  in1, in2, in3, in4;
  input [1:0] select;
  output  [31:0]  out;
  wire  [31:0]  w1, w2;
  Mux32Bit_2To1 Mux0(w1[31:0], select[0], in1[31:0], in2[31:0]);
  Mux32Bit_2To1 Mux1(w2[31:0], select[0], in3[31:0], in4[31:0]);
  Mux32Bit_2To1 Mux2(out[31:0], select[1], w1[31:0], w2[31:0]);
endmodule

module  TestBench_4To1Mux32Bit;
  reg [31:0] in1, in2, in3, in4;
  reg [1:0] select;
  wire  [31:0] out;
  Mux32Bit_4To1  Mux(out, select, in1, in2, in3, in4);
  initial begin
    $monitor($time, " Input1 = %b,\n\t Input2 = %b,\n\t Input3 = %b,\n\t Input4 = %b,\n\t Select = %b,\n\t Output = %b.", in1, in2, in3, in4, select, out);
    #0  in1 = 32'b10101010101010101010101010101010;  
        in2 = 32'b01010101010101010101010101010101;  
        in3 = 32'b00000000000000000000000000000000;
        in4 = 32'b11111111111111111111111111111111;
        select = 2'b00;
    #100  select  = 2'b01;
    #200  select  = 2'b10;
    #300  select  = 2'b11;
    #400  $finish;
  end
endmodule