module FSM(in, reset, clock, out);
  input in, reset, clock;
  output  out;
  reg [2:0]state;
  reg out;
  initial
    begin
      state <= 3'b000;
      out <= 1'b0;
    end
  always @ (posedge clock or posedge reset)
    begin
      if(reset)
        begin
          state <= 3'b000;
          out <= 1'b0;
        end
      else
        begin
          case(state)
            3'b000:
              begin
                if(in)
                  begin
                    state <= 3'b001;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 3'b000;
                    out <= 1'b0;
                  end
              end
            3'b001:
              begin
                if(in)
                  begin
                    state <= 3'b001;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 3'b010;
                    out <= 1'b0;
                  end
              end
            3'b010:
              begin
                if(in)
                  begin
                    state <= 3'b011;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 3'b000;
                    out <= 1'b0;
                  end
              end
            3'b011:
              begin
                if(in)
                  begin
                    state <= 3'b100;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 3'b010;
                    out <= 1'b0;
                  end
              end
            3'b100:
              begin
                if(in)
                  begin
                    state <= 3'b001;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 3'b010;
                    out <= 1'b1;
                  end
              end
          endcase
        end
    end
endmodule

module FSMTestbench;
  reg clock, reset, in;
  wire  out;
  reg [15:0]sequence;
  integer i;
  FSM mod(in, reset, clock, out);
  initial
    begin
      #0  clock = 1'b0; reset = 1'b1; sequence = 16'b0101101101110010;
      #5  reset = 1'b0;
      for(i=0; i<=15; i=i+1)
        begin
          in = sequence[i];
          #2  clock = 1'b1;
          #2  clock = 1'b0;
          $display("State = ", mod.state, ": Input = ", in, ", Output = ", out);
        end
    end
endmodule