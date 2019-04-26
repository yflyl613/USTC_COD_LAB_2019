`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 23:33:13
// Design Name: 
// Module Name: CMP
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


module CMP(
    input [5:0] x,
    input [5:0] y,
    output ug,
    output ul,
    output eq,
    output sg,
    output sl
    );
    wire [5:0] z;
    wire [2:0] f;
    ALU a(.s(3'b001),.a(x),.b(y),.y(z),.f(f));
    assign eq = f[2];
    assign ul = (f[0] == 1);
    assign ug = (f[0] == 0) & ~eq;
    assign sg = (~z[5] & ~eq & ~f[1]) | (z[5] & f[1]);
    assign sl = (z[5] & ~f[1]) | (~z[5] & f[1]);
endmodule
