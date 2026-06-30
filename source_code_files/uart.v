`timescale 1ns / 1ps



module uart #(parameter DSIZE=8)(
                input clock,
                input reset,
                input tx_start,
                input [DSIZE-1:0] data_in,
                input baud_tick,
                output reg tx_done,
                output reg tx_busy,
                output reg serial_out
    );
    
    localparam idle =3'b000;
    localparam start =3'b001;
    localparam data = 3'b010;
    localparam stop = 3'b011;
    localparam done = 3'b100;
    
    reg [2:0] present_state,next_state;
    reg [3:0] count;
    reg [DSIZE-1:0] shift;
    
    always@(posedge clock,negedge reset) begin
     if(!reset) 
        present_state <= idle;
     else
       present_state <= next_state;
    end
    
    
    always@(*) begin
                  
                   case(present_state) 
                             
                                idle: begin
                                         if(tx_start) begin
                                            //tx_busy =1;
                                            next_state = start;
                                           end  
                                          else 
                                            next_state = idle;
                                      end
                                 start: begin
                                          if(baud_tick)
                                            next_state = data;
                                          else
                                            next_state = start;
                                        end
                                 data:  begin
                                          if(baud_tick) begin 
                                               if(count == (DSIZE-1))
                                                next_state = stop;
                                              else
                                                next_state = data;
                                            end
                                          else
                                                next_state = data;
                                        end
                                 stop:  begin
                                          if(baud_tick)
                                            next_state = done;
                                          else
                                            next_state = stop;
                                        end
                                 done:  begin
                                            next_state = idle;
                                        end
                                        
                                 default: next_state = idle;
                  endcase
               end
    
     always@(posedge clock, negedge reset) begin
        
            if(!reset) begin
                            serial_out <= 1'b1;
                            tx_busy <= 1'b0;
                            tx_done <= 1'b0;
                            count <= 4'b0;
                            shift <= 0;
                      end
            else begin
          case(present_state)         
                        idle: begin
                                            serial_out <= 1'b1;
                                            tx_busy <= 1'b0;
                                            tx_done <= 1'b0;
                                            count <= 4'b0;
                                            if(tx_start) begin
                                               shift <= data_in;
                                             end
                              end
                                 
                        start: begin 
                                         if(baud_tick) begin
                                           serial_out <= 1'b0;
                                         end
                                           tx_busy <= 1'b1;
                                           tx_done <= 1'b0;
                               end 
                               
                        data:  begin
                                          if(baud_tick) begin
                                            serial_out <= shift[0];
                                            shift <= shift >> 1;
                                            count <= count+1;
                                          end
                                            tx_busy <= 1'b1;
                                            tx_done <= 1'b0;  
                               end
                               
                        stop:  begin
                                        if(baud_tick) begin
                                           serial_out <= 1'b1;
                                        end
                                            tx_busy <= 1'b1;
                                            tx_done <= 1'b0;
                               end
                       
                        done: begin
                                           // serial_out <= 1'b1;
                                            tx_busy <= 1'b0;
                                            tx_done <= 1'b1;
                              end
                endcase
       end
    end
                                     
endmodule
