module bcdToGray_beh(Out, In);
  integer i;
  input [3:0]In;
  wire [3:0]In;
  output [3:0]Out;
  reg [3:0]Out;
  always@(In)
  begin
    Out[3] = In[3];
    for(i = 3; i > -1; i=i-1)
      Out[i-1] = In[i] ^ In[i-1];
  end
endmodule
