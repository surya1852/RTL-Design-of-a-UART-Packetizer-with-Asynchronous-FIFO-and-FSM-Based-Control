`timescale 1ns / 1ps

module tb_top # (parameter DSIZE = 8) ();
                reg [DSIZE-1:0] data_in;
                reg clock;
                reg reset;
                reg data_valid;
                reg tx_ready;
                wire serial_out;
                wire fifo_full;
                wire tx_busy;
                
                
             top #(DSIZE) DUT (
                                .data_in(data_in),
                                .clock(clock),
                                .reset(reset),
                                .data_valid(data_valid),
                                .tx_ready(tx_ready),
                                .serial_out(serial_out),
                                .fifo_full(fifo_full),
                                .tx_busy(tx_busy)
                                );
                                
           always #10 clock = ~clock;
           integer i;
           
           
           initial begin
              clock =1;
              reset =0;
              data_valid =0;
              tx_ready =0;
              data_in = 8'b0;
              
              #20;
                reset=1;
                   for (i = 0; i < 16; i = i + 1) begin
                      #20;
                      data_in = 8'hC0 + i;     // Change data for visibility (C0, C1, C2...)
                      data_valid = 1;
                      #20;
                      data_valid = 0;
                    end
//              data_in = 8'b1100_0101;
//              data_valid = 1;
              
//              #20;
//              data_valid =0;
//              #50;
//              data_in = 8'b1010_0011;
//              data_valid = 1;
              
//              #20;
//              data_valid =0;
              
              #100;
              tx_ready =1;
              
              //#900 $finish();
              
           end
                
endmodule
