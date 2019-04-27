`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:13:08
// Design Name: 
// Module Name: TOP
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


module TOP(
    input clk_100M,
    input [11:0]rgb,
    input [3:0]dir,
    input draw,
    input rst,
    output [3:0]vga_red,vga_green,vga_blue,
    output HS,VS
    );
    wire [15:0]addr,vaddr;
    wire [11:0]pdata,vdata;
    wire we,valid;
    wire [7:0]x,y;
    wire clk_vga;
    wire [9:0]x_pos,y_pos;
    
    CLK_div m0(.clk_100M(clk_100M),.clk_vga(clk_vga));
    PCU m1(.rgb(rgb),.dir(dir),.draw(draw),.rst(rst),.clk_100M(clk_100M),.addr(addr),.pdata(pdata),.we(we),.x(x),.y(y));
    blk_mem_gen_0 m2(.clka(clk_100M),.wea(we),.addra(addr),.dina(pdata),.clkb(clk_vga),.addrb(vaddr),.doutb(vdata)); 
    VGA_Display m3(.clk_vga(clk_vga),.HS(HS),.VS(VS),.valid(valid),.x_pos(x_pos),.y_pos(y_pos));
    VGA_color m4(.valid(valid),.x(x),.y(y),.x_pos(x_pos),.y_pos(y_pos),.vdata(vdata),.vaddr(vaddr),.vga_red(vga_red),.vga_green(vga_green),.vga_blue(vga_blue)); 
    
endmodule
