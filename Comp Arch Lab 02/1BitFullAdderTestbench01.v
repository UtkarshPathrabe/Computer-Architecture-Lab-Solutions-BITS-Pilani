module testbench_1BFA;
  reg x,y,z;
  wire  s,c;
  FADDER  fl(s,c,x,y,z);
  initial
    begin
      $monitor($time," x = %b, y = %b, z = %b, carry = %b, sum = %b.", x, y, z, c, s);
      #0 x=1'b0; y=1'b0; z=1'b0;
      #4 x=1'b0; y=1'b0; z=1'b1;
      #4 x=1'b0; y=1'b1; z=1'b0;
      #4 x=1'b0; y=1'b1; z=1'b1;
      #4 x=1'b1; y=1'b0; z=1'b0;
      #4 x=1'b1; y=1'b0; z=1'b1;
      #4 x=1'b1; y=1'b1; z=1'b0;
      #4 x=1'b1; y=1'b1; z=1'b1;
    end
endmodule