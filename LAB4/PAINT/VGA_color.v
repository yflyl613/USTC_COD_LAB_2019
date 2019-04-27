`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:59:53
// Design Name: 
// Module Name: VGA_color
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

module VGA_color(
	input valid,
    input [7:0] x,
    input [7:0] y,
    input [9:0] x_pos,
    input [9:0] y_pos,
    input [11:0]vdata,
    output reg [15:0]vaddr,
	output reg [3:0]vga_red,
	output reg [3:0]vga_green,
	output reg [3:0]vga_blue
);

always @(*)
    begin
        if(x_pos>=191 && x_pos<=446 && y_pos>=111 && y_pos<=366)    vaddr=(y_pos-111)*256+(x_pos-191);
        if(valid && x_pos>=191 && x_pos<=446 && y_pos>=111 && y_pos<=366)
        begin
            if((x_pos==x+193&&y_pos>=y+109&&y_pos<=y+113)||(y_pos==y+111&&x_pos>=x+191&&x_pos<=x+195))
            begin
                if(x_pos==x+193&&y_pos==y+111)  {vga_red,vga_green,vga_blue} = vdata;
                else
                begin
                    vga_red = 4'b1111^vdata[11:8];
                    vga_green = 4'b1111^vdata[7:4];
                    vga_blue = 4'b1111^vdata[3:0];
                end
            end  
            else
            begin 
                vga_red = vdata[11:8];
                vga_green = vdata[7:4];
                vga_blue = vdata[3:0];
            end
        end  
        else
        begin
            vga_red = 4'b0000;
            vga_green = 4'b0000;
            vga_blue = 4'b0000;
         end  
     end  
endmodule
