module ShiftReg(in, en, clock, q);
  parameter n = 4;
  input in, en, clock;
  output [n-1:0]q;
  reg [n-1:0]q;
  initial
    q = 4'd10;
    always @ (posedge clock)
      begin
        if(en)
          q = {in, q[n-1:1]};
      end
endmodule

module ShiftRegTestBench;
  parameter n = 4;
  reg en, in, clock;
  wire [n-1:0]q;
  ShiftReg mod(in, en, clock, q);
  initial
    begin
      clock = 1'b0;
      repeat (10)
      #2  clock = ~clock;
    end
  initial
    begin
      $monitor($time, " Enable = %b, Input = %b, Q = %b.", en, in, q);
      #1  in = 1'b0;  en = 1'b0;
      #4  in = 1'b1;  en = 1'b1;
      #4  in = 1'b1;  en = 1'b0;
      #4  in = 1'b0;  en = 1'b1;
    end
endmodule