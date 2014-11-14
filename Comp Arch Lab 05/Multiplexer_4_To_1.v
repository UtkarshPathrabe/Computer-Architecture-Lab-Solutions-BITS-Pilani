module mux4_1(Out, Data0, Data1, Data2, Data3, Select);
  input [31:0]  Data0, Data1, Data2, Data3;
  input [1:0] Select;
  output  [31:0]  Out;
  reg [31:0]  Out;
  always @ (Data0 or Data1 or Data2 or Data3 or Select)
    case  (Select)
      2'b00:  Out = Data0;
      2'b01:  Out = Data1;
      2'b10:  Out = Data2;
      2'b11:  Out = Data3;
    endcase
endmodule

module  tbMux4_1;
  reg [31:0]  Data0, Data1, Data2, Data3;
  reg [1:0] Select;
  wire  [31:0]  Out;
  mux4_1  m(Out, Data0, Data1, Data2, Data3, Select);
  initial begin
    $monitor($time, " Data0 = %b, Data1 = %b, Data2 = %b, Data3 = %b, Select = %b, Output = %b.", Data0, Data1, Data2, Data3, Select, Out);
    #0  Data0 = 32'hF0F0F0F0; Data1 = 32'hF8F8F8F8; Data2 = 32'hFBFBFBFB; Data3 = 32'hFFFFFFFF;
    #5  Select = 2'b00;
    #5  Select = 2'b01;
    #5  Select = 2'b10;
    #5  Select = 2'b11;
    #5  $finish;
  end
endmodule