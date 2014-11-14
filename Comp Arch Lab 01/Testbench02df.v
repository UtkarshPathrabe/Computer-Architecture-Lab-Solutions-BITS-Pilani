module testbench02;
  reg [3:0]In;
  wire [3:0]Out;
  bcdToGray_df mod(Out, In);
  initial
  begin
    $monitor($time, " In=%4b, Out=%4b.", In, Out);
    #0  In = 4'b0000;
      repeat(9)
    #10 In = In + 4'b0001;
  end
endmodule
