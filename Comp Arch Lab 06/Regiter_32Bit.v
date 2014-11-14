module d_ff(q, d, clock, reset);
  input d, clock, reset;
  output  q;
  reg q;
  always @ (posedge clock or negedge reset)
  if(~reset)
    q = 1'b0;
  else
    q = d;
endmodule

module reg_32bit(q, d, clock, reset);
  input [31:0]  d;
  input clock, reset;
  output  [31:0]  q;
  genvar j;
  generate
    for(j = 0; j < 32; j = j + 1) begin:  d_loop
      d_ff ff(q[j], d[j], clock, reset);
    end
  endgenerate
endmodule