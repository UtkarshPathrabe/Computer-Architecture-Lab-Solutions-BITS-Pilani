module testbench_mux16;
  reg [0:15]in;
  reg [0:3]select;
  wire  out;
  mux16To1_gate mux(out, in, select);
  initial
    begin
      $monitor($time, " Input=%b, Select=%b, Output=%b.", in, select, out);
      #0  in = 16'b1000000000000000;  select = 4'b0000;
      repeat(15)
        begin
          #3  in = in>>1'b1;  select = select + 4'b0001;
        end
    end
endmodule