module mux32_1(Out, Data00, Data01, Data02, Data03, Data04, Data05, Data06, Data07, Data08, Data09, Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, Data24, Data25, Data26, Data27, Data28, Data29, Data30, Data31, Select);
  input [31:0]  Data00, Data01, Data02, Data03, Data04, Data05, Data06, Data07, Data08, Data09, Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23, Data24, Data25, Data26, Data27, Data28, Data29, Data30, Data31;
  input [4:0] Select;
  output  [31:0]  Out;
  reg [31:0]  Out;
  always @ (Data00 or Data01 or Data02 or Data03 or Data04 or Data05 or Data06 or Data07 or Data08 or Data09 or Data10 or Data11 or Data12 or Data13 or Data14 or Data15 or Data16 or Data17 or Data18 or Data19 or Data20 or Data21 or Data22 or Data23 or Data24 or Data25 or Data26 or Data27 or Data28 or Data29 or Data30 or Data31 or Select)
    case  (Select)
      5'b00000:  Out = Data00;
      5'b00001:  Out = Data01;
      5'b00010:  Out = Data02;
      5'b00011:  Out = Data03;
      5'b00100:  Out = Data04;
      5'b00101:  Out = Data05;
      5'b00110:  Out = Data06;
      5'b00111:  Out = Data07;
      5'b01000:  Out = Data08;
      5'b01001:  Out = Data09;
      5'b01010:  Out = Data10;
      5'b01011:  Out = Data11;
      5'b01100:  Out = Data12;
      5'b01101:  Out = Data13;
      5'b01110:  Out = Data14;
      5'b01111:  Out = Data15;
      5'b10000:  Out = Data16;
      5'b10001:  Out = Data17;
      5'b10010:  Out = Data18;
      5'b10011:  Out = Data19;
      5'b10100:  Out = Data20;
      5'b10101:  Out = Data21;
      5'b10110:  Out = Data22;
      5'b10111:  Out = Data23;
      5'b11000:  Out = Data24;
      5'b11001:  Out = Data25;
      5'b11010:  Out = Data26;
      5'b11011:  Out = Data27;
      5'b11100:  Out = Data28;
      5'b11101:  Out = Data29;
      5'b11110:  Out = Data30;
      5'b11111:  Out = Data31;
    endcase
endmodule