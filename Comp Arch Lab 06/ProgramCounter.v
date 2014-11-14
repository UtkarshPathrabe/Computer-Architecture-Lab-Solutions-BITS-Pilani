module PC(count, clock, reset);
  input		clock, reset;
  output	[31:0]	count;
  reg	[31:0]	count;
  always @(posedge clock)
    if(!reset)
      count = count + 1;
    else
      count = 0;
endmodule

module TBPC;
  reg clock, reset;
  wire [31:0] count;
  PC pc(count, clock, reset);
  initial begin
    repeat(1000)
    # 5 clock = ~clock;
  end
  initial begin
    $monitor($time, " Reset = %b, Count= %b.", reset, count);
    #0  clock = 1'b0; reset = 1'b1;
    #11  reset = 1'b0;
  end
endmodule