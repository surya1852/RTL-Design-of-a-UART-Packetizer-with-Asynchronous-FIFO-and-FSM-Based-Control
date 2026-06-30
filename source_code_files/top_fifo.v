`timescale 1ns / 1ps


module top_fifo #(parameter DSIZE =8) (
                        input [DSIZE-1:0] wdata,    
                        input winc,                    
                        input wclk,
                        input wrst_n,       // Write increment, write clock, write reset
                        input rinc,
                        input rclk,
                        input rrst_n,       // Read increment, read clock, read reset
                        output [DSIZE-1:0] rdata,       
                        output wfull,                   
                        output rempty  
                          );
                          
           asynchronus_fifo  #(DSIZE)  ff(
                                 .wdata(wdata),
                                 .winc(winc),
                                 .wclk(wclk),
                                 .wrst_n(wrst_n),
                                 .rinc(rinc),
                                 .rclk(rclk),
                                 .rrst_n(rrst_n),
                                 .rdata(rdata),
                                 .wfull(wfull),
                                 .rempty(rempty)
                                 );
endmodule
