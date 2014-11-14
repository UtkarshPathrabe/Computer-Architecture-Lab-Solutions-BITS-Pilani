module DFlipFlop_Sync_Clear(d, not_clear, clock, q);
  input d, not_clear, clock;
  output  q;
  reg q;
  always @ (posedge clock)
    begin
      if(!not_clear)
        q <= 1'b0;
      else
        q <= d;
    end
endmodule

module DFlipFlop_Async_Clear(d, not_clear, clock, q);
  input d, not_clear, clock;
  output  q;
  reg q;
  always @ (negedge not_clear or posedge clock)
    begin
      if(!not_clear)
        q <= 1'b0;
      else
        q <= d;
    end
endmodule

module Testbench_Sync_Clear;
  reg d, reset, clock;
  wire  q;
  DFlipFlop_Sync_Clear dff1(d, reset, clock, q);
  initial
    begin
      #0  clock = 1'b0;
      repeat(10)
      #5 clock = ~clock;
    end
  initial
    begin
      $monitor($time, " D = %b, Reset = %b, Clock = %b, Q = %b.", d, reset, clock, q);
      #01 d = 1'b0; reset = 1'b0;
      #10 d = 1'b1; reset = 1'b1;
      #10 d = 1'b0; reset = 1'b1;
      #10 d = 1'b1; reset = 1'b0;
    end
endmodule

module Testbench_Async_Clear;
  reg d, reset, clock;
  wire  q;
  DFlipFlop_Async_Clear dff2(d, reset, clock, q);
  initial
    begin
      #0  clock = 1'b0;
      repeat(10)
      #5 clock = ~clock;
    end
  initial
    begin
      $monitor($time, " D = %b, Reset = %b, Clock = %b, Q = %b.", d, reset, clock, q);
      #01 d = 1'b0; reset = 1'b0;
      #10 d = 1'b1; reset = 1'b1;
      #10 d = 1'b0; reset = 1'b1;
      #10 d = 1'b1; reset = 1'b0;
    end
endmodule