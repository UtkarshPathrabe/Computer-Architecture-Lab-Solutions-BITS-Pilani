module SyncCounter(CountEn, clock, Q);
  input CountEn, clock;
  output  [3:0]Q;
  wire w0, w1, w2;
  JK_Flip_Flop  jk1(CountEn, CountEn, clock, Q[0]);
  and gate1(w0, CountEn, Q[0]);
  JK_Flip_Flop  jk2(w0, w0, clock, Q[1]);
  and gate2(w1, w0, Q[1]);
  JK_Flip_Flop  jk3(w1, w1, clock, Q[2]);
  and gate3(w2, w1, Q[2]);
  JK_Flip_Flop  jk4(w2, w2, clock, Q[3]);
endmodule

module SyncCounterTestBench;
  reg CountEn, clock;
  wire  [3:0]Q;
  SyncCounter mod(CountEn, clock, Q);
  initial
    begin
      $monitor($time, " Output = %b", Q);
      clock = 1'b0; CountEn = 1'b0;
      #10 CountEn = 1'b1;
      #165  $finish;
    end
  always
    #5  clock = ~clock;
endmodule