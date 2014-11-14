module MUX5Bit_2To1(out, select, q1, q2);
	input  [4:0] q1, q2;
	input select;
	output [4:0] out;
	genvar  j;
  generate  for(j = 0; j < 5; j = j + 1)  
    begin:  mux_loop
      Mux2To1 Mux(out[j], select, q1[j], q2[j]);
    end
  endgenerate
endmodule

module TBMux5Bit_2To1;
  reg [4:0] q1, q2;
  reg select;
  wire [4:0] out;
  MUX5Bit_2To1 mux(out, select, q1, q2);
  initial begin
    $monitor($time, " Q1 = %b, Q2 = %b, Select = %b, Output = %b.", q1, q2, select, out);
    #0  q1 = 5'b10101; q2 = 5'b01010; select = 1'b0;
    #50  select = 1'b1;
    #100 $finish;
  end
endmodule