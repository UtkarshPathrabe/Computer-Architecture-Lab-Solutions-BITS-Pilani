//shift register to store the two inputs a and b to be added
module shift(y, d, clk);
  input [3:0] d;
  input clk;
  output [3:0] y;
  reg [3:0] y;
  initial begin
    assign y=d;
  end
  always @(posedge clk)
    begin
      assign y=y>>1;
    end
endmodule

//serial in parallel out register to store the 4 bit sum
module sipo(y, s, clk);
  input  s, clk;
  output [3:0] y;
  reg [3:0] y;
  always @(posedge clk)
    begin
      assign y={s,y[3:1]};
    end
endmodule

//1 bit full adder
module fa(s, cout, a, b, cin);
  input a, b, cin;
  output s, cout;
  assign {cout, s} = a + b + cin;
endmodule

//d flipflop to store the cout of each stage
module dff(q, d, clk);
  input d, clk;
  output q;
  reg q;
  initial begin
    q = 1'b0;
  end
  always @(posedge clk)
    begin
      q = d;
    end
endmodule

//main module serial adder//
module serial(sum, cout, a, b, clk);
  input [3:0] a, b;
  input clk;
  wire [3:0] x, z;
  output [3:0] sum; 
  output cout;
  wire s, cin;
  fa k(s, cout, x[0], z[0], cin);     //1 bit full adder
  dff q(cin, cout, clk);              //d flipflop to store the cout value after each 1 bit full adder operation
  sipo m(sum, s, clk);                //serial sum(s) converted to parallel output(4 bit sum)///
  shift g(x, a, clk);                 //shifts the input a
  shift h(z, b, clk);                 //shifts the input b
endmodule

module SATestBench;
  reg [3:0] a, b;
  reg clock;
  wire  cout;
  wire  [3:0] sum;
  serial  sa(sum, cout, a, b, clock);
  initial begin
    #5  clock = 1'b0;
    repeat(6)
    # 5 clock = ~clock;
  end
  initial begin
    #0  a = 4'b1000;  b=4'b0110;
    $monitor($time, " A = %b, B = %b, CarryOut = %b, Sum = %b.", a, b, cout, sum);
  end
endmodule