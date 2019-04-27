`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:50:03
// Design Name: 
// Module Name: VRAM
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


module CLK_div(
    input clk_100M,
    output clk_vga
    );
    reg [31:0] cnt=0;
        
    assign clk_vga = cnt[1];
    
    always @(posedge clk_100M) cnt <= cnt + 1;
endmodule
