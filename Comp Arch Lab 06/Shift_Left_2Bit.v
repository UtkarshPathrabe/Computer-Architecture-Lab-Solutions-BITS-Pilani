module Shift_Left(out, in);
	input [31:0] in;
	output [31:0] out;
	assign out = {in[29:0],1'b0,1'b0};
endmodule

module TBShiftLeft;
  reg [31:0] in;
  wire [31:0] out;
  Shift_Left sl(out, in);
  initial begin
    $monitor($time, " :Input = %b,\t Output = %b.", in, out);
    #0  in = 32'h2345F000;
    #100  in = 32'h81234011;
    #100  in = 32'h89018310;
    #100  in = 32'hAAAA9999;
    #200  $finish;
  end
endmodule