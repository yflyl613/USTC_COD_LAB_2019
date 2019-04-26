`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 23:14:24
// Design Name: 
// Module Name: REG
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


module REG(
    input [5:0] in,
    input en,
    input rst,
    input clk,
    output reg [5:0] out
    );
    always @(posedge clk or posedge rst)
        if(rst)
            out <= 6'b000000;
        else 
        begin
            if(en)
                out <= in;
        end     
endmodule
