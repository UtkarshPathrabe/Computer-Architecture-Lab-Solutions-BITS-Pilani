module JK_Flip_Flop(J, K, clock, Q);
  input J, K, clock;
  output  Q;
  reg Q;
  initial
    Q = 1'b0;
  always @(posedge clock)
    case({J, K})
      2'b00:  Q <= Q;
      2'b01:  Q <= 1'b0;
      2'b10:  Q <= 1'b1;
      2'b11:  Q <= ~Q;
    endcase
endmodule