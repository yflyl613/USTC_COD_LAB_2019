`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 13:01:27
// Design Name: 
// Module Name: input_process
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


module input_process(
    input [3:0]in,
    input clk_100M,
    output [3:0]out
    );
    wire [3:0]in_shake_remove;
    
    shake_remove m0(.in(in[0]),.clk_100M(clk_100M),.out(in_shake_remove[0]));
    shake_remove m1(.in(in[1]),.clk_100M(clk_100M),.out(in_shake_remove[1]));
    shake_remove m2(.in(in[2]),.clk_100M(clk_100M),.out(in_shake_remove[2]));
    shake_remove m3(.in(in[3]),.clk_100M(clk_100M),.out(in_shake_remove[3]));
    
    signal_process p0(.in(in_shake_remove[0]),.clk_100M(clk_100M),.out(out[0]));
    signal_process p1(.in(in_shake_remove[1]),.clk_100M(clk_100M),.out(out[1]));
    signal_process p2(.in(in_shake_remove[2]),.clk_100M(clk_100M),.out(out[2]));
    signal_process p3(.in(in_shake_remove[3]),.clk_100M(clk_100M),.out(out[3]));
endmodule
