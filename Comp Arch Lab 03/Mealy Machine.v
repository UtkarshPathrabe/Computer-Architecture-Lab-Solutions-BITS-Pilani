module Mealy(in, clock, reset, out);
  input in, clock, reset;
  output  out;
  reg [1:0]state;
  reg out;
  always @ (posedge clock or posedge reset)
    begin
      if(reset)
        begin
          state <= 2'b00;
          out <= 1'b0;
        end
      else
        begin
          case(state)
            2'b00:  
              begin
                if(in)
                  begin
                    state <= 2'b01;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 2'b10;
                    out <= 1'b0;
                  end
              end
            2'b01:
              begin
                if(in)
                  begin
                    state <= 2'b00;
                    out <= 1'b1;
                  end
                else
                  begin
                    state <= 2'b10;
                    out <= 1'b0;
                  end
              end
            2'b10:
              begin
                if(in)
                  begin
                    state <= 2'b01;
                    out <= 1'b0;
                  end
                else
                  begin
                    state <= 2'b00;
                    out <= 1'b1;
                  end
              end
          endcase
        end
    end
endmodule

module MealyTestbench;
  reg clock, reset, in;
  wire  out;
  reg [15:0]sequence;
  integer i;
  Mealy mod(in, clock, reset, out);
  initial
    begin
      #0  clock = 1'b0; reset = 1'b1; sequence = 16'b0101011101110010;
      #5  reset = 1'b0;
      for(i=0; i<=15; i=i+1)
        begin
          in = sequence[i];
          #2  clock = 1'b1;
          #2  clock = 1'b0;
          $display("State = ", mod.state, ": Input = ", in, ", Output = ", out);
        end
        testing;
    end
    
    task testing;
      for(i=0; i<=15; i=i+1)
        begin
          in = $random % 2;
          #2  clock = 1'b1;
          #2  clock = 1'b0;
          $display("State = ", mod.state, ": Input = ", in, ", Output = ", out);
        end
    endtask
endmodule