`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/16 11:29:24
// Design Name: 
// Module Name: FIB
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
module MUX(
    input [5:0]a,
    input [5:0]b,
    input s,
    output reg [5:0]c
    );
    always @(*)
    begin
        if(~s) c=a;
        else c=b;
    end
endmodule

module FIB(
    input [5:0] f0, 
    input [5:0] f1,
    input rst,
    input clk,
    output [5:0] fn
    );
    wire [5:0]in,op_1,op_2,out;
    wire [2:0]f;
    wire s;
    reg flag=0;   
    ALU a(.s(3'b000),.a(op_1),.b(op_2),.f(f),.y(out));
    MUX m1(.a(f1),.b(fn),.s(s),.c(op_1));
    REG r1(.in(op_1),.en(1),.rst(rst),.clk(clk),.out(in));
    MUX m2(.a(f0),.b(in),.s(s),.c(op_2));
    REG r2(.in(out),.en(1),.rst(rst),.clk(clk),.out(fn));
    assign s = flag;
    always @(posedge clk or posedge rst)
    begin
        if(rst)    flag<=0;
        else flag<=1;
    end
endmodule
