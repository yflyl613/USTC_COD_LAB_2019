`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/16 10:45:13
// Design Name: 
// Module Name: ACM
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


module ACM(
    input [5:0] x,
    input rst,
    input clk,
    output [5:0] s
    );
    wire [5:0]op_1,op_2,out;
    wire [2:0]f;
    assign s=out;
    REG r1(.in(x),.en(1),.rst(rst),.clk(clk),.out(op_1));
    REG r2(.in(out),.en(1),.rst(rst),.clk(clk),.out(op_2));
    ALU a1(.s(3'b000),.a(op_1),.b(op_2),.y(out),.f(f));
endmodule
