`timescale 1ns / 1ps



module synch #(parameter ASIZE =4)(
    input [ASIZE:0] din,      
    input clk,
    input  rst_n,            
    output reg [ASIZE:0] q2
    );

    reg [ASIZE:0] q1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            {q2, q1} <= 2'b0;         
        else 
            {q2, q1} <= {q1, din};  
    end 

endmodule