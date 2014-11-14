module decoder2_4(Out, In);
  input [1:0] In;
  output  [3:0] Out;
  assign  Out[0] = (~In[1] & ~In[0]),
          Out[1] = (~In[1] & In[0]),
          Out[2] = (In[1] & ~In[0]),
          Out[3] = (In[1] & In[0]);
endmodule