`timescale 1ns / 1ps


module clockdivide(
                  
                     input clock,
                     input reset,
                     output reg clock_out
    );
    
    
    initial begin
      clock_out =0;
      end
      
    always@(posedge clock,negedge reset) begin
     if(!reset)
       begin
         clock_out <=0;
       end
     else 
        begin
          clock_out <= ~clock_out;
        end
     end
  
endmodule
