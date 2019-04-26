`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 22:41:56
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] s,
    input [5:0] a,
    input [5:0] b,
    output reg [5:0] y,
    output reg [3:0] f
    );
    reg c,e;
    reg [5:0] d;
    always @(*)
    begin
        c=0;
        case(s)         //add=000,minus=001,and=010,or=011,not=100,xor=101
            3'b000:begin
                        {c,y}=a+b;
                        f[1] = (a[5]&b[5]&~y[5])|(~a[5]&~b[5]&y[5]);
                        f[3] = y[5];
                   end
            3'b001:begin
                        d=~b+1;
                        {e,y}=a+d;
                        c=~e;
                        f[1] = (a[5]&d[5]&~y[5])|(~a[5]&~d[5]&y[5]);
                        f[3] = y[5];
                    end
            3'b010:y =a&b;
            3'b011:y=a|b;
            3'b100:y=~a;
            3'b101:y=a^b;
        endcase         //f[0]=CF f[1]=OF f[2]=ZF f[3]=SF
        f[0]= c;
        f[2]= ~(y[5]|y[4]|y[3]|y[2]|y[1]|y[0]);
    end
endmodule
