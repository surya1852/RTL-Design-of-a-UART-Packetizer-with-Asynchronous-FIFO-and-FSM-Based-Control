`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 22:12:31
// Design Name: 
// Module Name: top_design
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_design # (parameter DSIZE =8)(
                    input [DSIZE-1:0] data_in,
                    input clock,
                    input reset,
                    input data_valid,
                    input tx_ready,
                    output serial_out,
                    output fifo_full,
                    output tx_busy          
    );
    
    wire clock2;
    wire [DSIZE-1:0] data_temp;
    wire [DSIZE-1:0] data_temp_fsm;
    wire ff_empty;
    wire read_enable;
    wire uart_start;
    wire uart_done;
    //wire uart_busy;
    wire baud_tick;
    
    clockdivide DUT1 (
                       .clock(clock),
                       .reset(reset),
                       .clock_out(clock2)
                       );
    
    top_fifo #(DSIZE) DUT2 (
                           .wdata(data_in),
                           .wclk(clock),
                           .rrst_n(reset),
                           .wrst_n(reset),
                           .rclk(clock2),
                           .winc(data_valid),
                           .rinc(read_enable),
                           .rdata(data_temp),
                           .wfull(fifo_full),
                           .rempty(ff_empty)                   
                           );
                           
         fsm #(DSIZE) DUT3 (
                               .clock(clock2),
                               .reset(reset),
                               .data_in(data_temp),
                               .tx_done(uart_done),     // inputs connect from the output of the uart
                               .tx_busy(tx_busy),   // inputs connect from the output of the uart
                               .tx_ready(tx_ready),
                               .fifo_empty(ff_empty),
                               .data_out(data_temp_fsm),
                               .tx_start(uart_start),    // output of the fsm connect to input of the uart
                               .fifo_read_enable(read_enable)
                            );
                            
          baud_time DUT4 (
                             .clock(clock2),
                             .reset(reset),
                             .baud_tick(baud_tick)
                             );
                             
          uart #(DSIZE) DUT5 (
                                  .clock(clock2),
                                  .reset(reset),
                                  .tx_start(uart_start),
                                  .data_in(data_temp_fsm),
                                  .baud_tick(baud_tick),
                                  .tx_done(uart_done),
                                  .tx_busy(tx_busy),
                                  .serial_out(serial_out)
                                  );
          
    
endmodule
