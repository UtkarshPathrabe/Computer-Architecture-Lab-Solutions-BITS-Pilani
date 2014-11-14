module testbench_8BFA;
  reg [7:0] A, B;
  reg CarryIn;
  wire  [7:0]Sum;
  wire  Carry;
  integer i, j;
  FADDER8 mod(Sum, Carry, A, B, CarryIn);
  
  initial
    begin
      $monitor($time," A = %b, B = %b, Carry In = %b, Carry = %b, Sum = %b.", A, B, CarryIn, Carry, Sum);
      #0  A=8'b00000000;  B=8'b00000000;  CarryIn=1'b0;
      for(i=0; i<256; i=i+1)
        begin
          for(j=0; j<256; j=j+1)
            begin
              #3  CarryIn=1'b0;
              #3  CarryIn = CarryIn+1'b1;
              B=B+8'b00000001;
            end
            A=A+8'b00000001;
        end
    end
endmodule