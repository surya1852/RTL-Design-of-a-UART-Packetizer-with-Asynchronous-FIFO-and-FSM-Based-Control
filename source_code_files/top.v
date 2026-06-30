`timescale 1ns / 1ps


module top #(parameter DSIZE =8)(
                    input [DSIZE-1:0] data_in,
                    input clock,
                    input reset,
                    input data_valid,
                    input tx_ready,
                    output serial_out,
                    output fifo_full,
                    output tx_busy    

    );
    
    top_design #(DSIZE) DUT (
                                .data_in(data_in),
                                .clock(clock),
                                .reset(reset),
                                .data_valid(data_valid),
                                .tx_ready(tx_ready),
                                .serial_out(serial_out),
                                .fifo_full(fifo_full),
                                .tx_busy(tx_busy)
                                );    
endmodule
