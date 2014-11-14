module bcdToGray_df(Out, In);
  input [3:0]In;
  output [3:0]Out;
  assign  Out[3] = In[3],
          Out[2:0] = In[3:1] ^ In[2:0];
endmodule
