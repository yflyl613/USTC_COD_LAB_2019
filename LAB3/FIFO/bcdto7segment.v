`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/31 00:19:47
// Design Name: 
// Module Name: bcdto7segment
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


module bcdto7segment(
    input [3:0]x,
    input [2:0]front,num,
    output reg [7:0]seg     //MSB¿ØÖÆ"."
    );
    always @(*)
    begin
        if(num==front)    seg[7]=0;
        else seg[7]=1;
    case(x)
        4'b0000: seg[6:0] = 7'b0000001;  
        4'b0001: seg[6:0] = 7'b1001111;
        4'b0010: seg[6:0] = 7'b0010010;
        4'b0011: seg[6:0] = 7'b0000110;    
        4'b0100: seg[6:0] = 7'b1001100;    
        4'b0101: seg[6:0] = 7'b0100100;          
        4'b0110: seg[6:0] = 7'b0100000;    
        4'b0111: seg[6:0] = 7'b0001111;
        4'b1000: seg[6:0] = 7'b0000000;           
        4'b1001: seg[6:0] = 7'b0000100;           
        default: seg[6:0] = 7'b1111111;
    endcase
    end
endmodule
