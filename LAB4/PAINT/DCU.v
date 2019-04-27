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


module VGA_Display(
	input clk_vga,
	output HS,
	output VS,
	output valid,
    output [9:0] x_pos,
    output [9:0] y_pos
    );

	reg [9:0]h_count=0;
	reg [9:0]v_count=0;	
	
	always@(posedge clk_vga)
	begin
		if(h_count == 10'd799)
			h_count <= 10'h0;
		else
			h_count <= h_count + 10'h1;
	end

	assign x_pos = h_count - 10'd143;
	assign HS = (h_count >= 10'd96);

	always@(posedge clk_vga)
	begin
		if(h_count == 10'd799)begin		
			if(v_count == 10'd524)v_count <= 10'h0;
			else v_count <= v_count + 10'h1;
		end
	end

	assign y_pos = v_count - 10'd35;
	assign VS = (v_count >= 10'd2);
	assign valid = (((h_count >= 10'd143)&&(h_count < 10'd783)) && ((v_count >= 10'd35) && (v_count < 10'd515)));	
		
endmodule 
