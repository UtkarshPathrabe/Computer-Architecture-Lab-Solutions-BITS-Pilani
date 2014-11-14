module Sign_Extender(out, in);
	input [15:0] in;
	output [31:0] out;
	assign out = { {16{in[15]}}, in};	
endmodule

module TBSignExtender;
  reg [15:0] in;
  wire [31:0] out;
  Sign_Extender se(out, in);
  initial begin
    $monitor($time, " :Input = %b,\t Output = %b.", in, out);
    #0  in = 16'hF000;
    #100  in = 16'h011;
    #100  in = 16'h8310;
    #100  in = 16'h9999;
    #200  $finish;
  end
endmodule