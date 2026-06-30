`timescale 1ns / 1ps



module memory #(parameter DSIZE = 6,parameter ASIZE = 4)(        
    input [DSIZE-1:0] wdata,         
    input [ASIZE-1:0] waddr,
    input [ASIZE-1:0] raddr,  
    input wclk_en,
    input wfull,
    input wclk, 
    input rclk,
    input rclk_en,
    input rempty,
    output reg [DSIZE-1:0] rdata        
      );
      
     localparam DEPTH = 1 << ASIZE;    //declaring memory locations 
      reg [DSIZE-1:0] mem [0:DEPTH-1];     // initating memory locations
      
      /// performing write operation 
       always @(posedge wclk)
        begin
                if (wclk_en && !wfull)
                  begin
                      mem[waddr] = wdata; // Write data
                      $display("data=%0h,address=%0h",wdata,waddr);
                   end
//                else 
//                    begin
//                        mem[waddr] = 0;
//                     end
        end
         //$display("mem= %0p,waddr=%h,full=%0b",mem,waddr,wfull);
        
        /// performing read operation
        always @(*) 
        begin
          //if(rclk_en)
         if(rclk_en && !rempty)
           begin
              rdata=mem[raddr];
               $display("data output=%0h,address output=%0h",rdata,raddr);
           end
         else 
            begin       
               rdata=0;
            end
        end
  endmodule 