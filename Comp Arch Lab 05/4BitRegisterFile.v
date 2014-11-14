module RegFile_4(ReadData1, ReadData2, Clock, Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData);
  input Clock, Reset, RegWrite;
  input [1:0] ReadReg1, ReadReg2, WriteRegNo;
  input [31:0]  WriteData;
  output  [31:0]  ReadData1, ReadData2;
  wire  [31:0]  w0, w1, w2, w3;
  wire  [3:0] Decode;
  wire  c0, c1, c2, c3;
  decoder2_4  dec(Decode, WriteRegNo);
  and g0(c0, RegWrite, Decode[0], Clock);
  and g1(c1, RegWrite, Decode[1], Clock);
  and g2(c2, RegWrite, Decode[2], Clock);
  and g3(c3, RegWrite, Decode[3], Clock);
  reg_32bit r0(w0, WriteData, c0, Reset);
  reg_32bit r1(w1, WriteData, c1, Reset);
  reg_32bit r2(w2, WriteData, c2, Reset);
  reg_32bit r3(w3, WriteData, c3, Reset);
  mux4_1  m0(ReadData1, w0, w1, w2, w3, ReadReg1);
  mux4_1  m1(ReadData2, w0, w1, w2, w3, ReadReg2);
endmodule

module tbRegFile4;
  reg Clock, Reset, RegWrite;
  reg [1:0] ReadReg1, ReadReg2, WriteRegNo;
  reg [31:0]  WriteData;
  wire  [31:0]  ReadData1, ReadData2;
  RegFile_4 rgf(ReadData1, ReadData2, Clock, Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData);
  initial begin
    $monitor($time, ": Reset = %b, RegWrite = %b, ReadReg1 = %b, ReadReg2 = %b, WriteRegNo = %b, WriteData = %b, ReadData1 = %b, ReadData2 = %b.", Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData, ReadData1, ReadData2);
    #0  Clock = 1'b1; ReadReg1 = 2'b00; ReadReg2 = 2'b01; Reset = 1'b1;
    #2  Reset = 1'b0;
    #10 Reset = 1'b1; RegWrite = 1'b1;  WriteData = 32'hF0F0F0F0; WriteRegNo = 2'b00;
    #10 RegWrite = 1'b1;  WriteData = 32'hF8F8F8F8; WriteRegNo = 2'b01;
    #10 RegWrite = 1'b1;  WriteData = 32'hFAFAFAFA; WriteRegNo = 2'b10;
    #10 RegWrite = 1'b1;  WriteData = 32'hFFFFFFFF; WriteRegNo = 2'b11;
    #10 RegWrite = 1'b0;
    #10 ReadReg1 = 2'b00; ReadReg2 = 2'b01;
    #10 ReadReg1 = 2'b10; ReadReg2 = 2'b11;
    #10 $finish;
  end
  always
    #5  Clock = ~Clock;
endmodule