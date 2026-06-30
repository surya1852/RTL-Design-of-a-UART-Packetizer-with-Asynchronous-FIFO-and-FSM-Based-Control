`timescale 1ns / 1ps

module fsm #(parameter DSIZE =8)(   
            input clock,
            input reset,
            input [DSIZE-1:0] data_in,
            input tx_done,
            input tx_busy,
            input tx_ready,
            input fifo_empty,
            output reg [DSIZE-1:0] data_out,
            output reg tx_start,
            output reg fifo_read_enable
              
    );
    
    localparam s0 = 2'b00;
    localparam s1 = 2'b01;
    localparam s2 = 2'b10;
    localparam s3 = 2'b11;
    
    reg [1:0] present_state, next_state;
    
    always@(posedge clock,negedge reset) begin
    if(!reset) begin
      present_state <= s0;
     end
    else begin
      present_state <= next_state;
     end
    end
    
    always@(*)
     begin
      
//      tx_start =0;
//      fifo_read_enable =0;
           case(present_state)
                               s0 : begin           // IDLE
                                      
                                        if(tx_ready && (!fifo_empty))
                                         
                                             next_state = s1;
                                        else
                                             next_state = s0;
                                      end
                                      
                               s1 : begin          //READ
                                         next_state = s2; 
                                      end
                                      
                               s2: begin           //LOAD
                                         next_state = s3;
                                   end
                                      
                               s3 : begin          //BUSY
                                          if(tx_done && (!tx_busy))
                                             next_state = s0;
                                          else
                                             next_state = s3;
                                      end
                              default : next_state = s0;
           endcase
     end
     
   always@(posedge clock, negedge reset) begin
     if(!reset) begin
          data_out <=8'b0;
          tx_start <= 1'b0;
          fifo_read_enable <= 1'b0;
        end
     else begin
        case (present_state) 
               s0 : begin
                       data_out <= 8'b0;
                       tx_start <= 1'b0;
                       fifo_read_enable <= 1'b0;
                    end
                      
               s1 : begin
                       data_out <= 8'b0;        // taking data from the fifo
                       tx_start <= 1'b0;
                       fifo_read_enable <= 1'b1;
                    end
                    
               s2  :begin
                       data_out <= data_in;     // giving data to the uart 
                       tx_start <= 1'b1;
                       fifo_read_enable <= 1'b0;
                     end
                    
               s3 : begin
                       data_out <= 8'b0;
                       tx_start <= 1'b0;
                       fifo_read_enable <= 1'b0;
                    end
              default: begin
                        data_out <= 8'b0;
                        tx_start <= 1'b0;
                        fifo_read_enable <= 1'b0;
                       end
        endcase
       end
    end
     
endmodule
