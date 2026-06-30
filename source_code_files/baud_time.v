`timescale 1ns / 1ps



module baud_time(
                  input clock,
                  input reset,
                  output reg baud_tick
    );
     
     localparam integer clockfrequency = 25000000;
     localparam integer baud_rate = 115200;
     localparam integer baud_div = clockfrequency/baud_rate;
     localparam integer width = $clog2(baud_div);
     
     reg [width-1:0] count;
    
    always@(posedge clock,negedge reset) begin
       if(!reset) begin
          baud_tick <=0;
          count <=0;
        end
       else begin
                   if(count == (baud_div-1)) begin
                      count <=0;
                      baud_tick <=1;
                      $display("Baud Tick: Time = %t, Count = %0d", $time, count);
                   end
                   else  begin
                        count <= count+1;
                        baud_tick <=0;
                        $display("Baud Tick: Time = %t, Count = %0d", $time, count);
                       end
         end
         
    end
               
            
endmodule
