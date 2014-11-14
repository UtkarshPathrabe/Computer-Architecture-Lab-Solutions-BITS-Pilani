module  ALUControlUnit(Op, Func, ALUOp);
  input [5:0] Func;
  input [1:0] ALUOp;
  output  [2:0] Op;
  assign  Op[0] = ALUOp[1] & (Func[3] | Func[0]);
  assign  Op[1] = (~ALUOp[1]) | (~Func[2]);
  assign  Op[2] = ALUOp[0] | (ALUOp[1] & Func[1]);
endmodule