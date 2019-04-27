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


module VRAM(
    input [15:0]paddr,
    input [11:0]pdata,
    input we,
    input [15:0]vaddr,
    output [11:0]vdata,
    input clk_100M
    );
    dist_mem_gen_0 m0(.a(paddr),.d(pdata),.dpra(vaddr),.clk(clk_100M),.we(we),.dpo(vdata));
    
endmodule
