`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/30 10:10:15
// Design Name: 
// Module Name: REG_FILE
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


module REG_FILE #(parameter N=6,A=3)(
    input [A-1:0]ra0,ra1,wa,
    input [N-1:0]wd,
    input we,rst,clk,
    output [N-1:0]rd0,rd1
    );
    reg [N-1:0]REG_FILE[7:0];
   
    assign rd0 = REG_FILE[ra0];
    assign rd1 = REG_FILE[ra1];    
    
    always @(posedge clk or posedge rst)
    if(rst)
    begin
        REG_FILE[0]<=6'b000000;
        REG_FILE[1]<=6'b000000;
        REG_FILE[2]<=6'b000000;
        REG_FILE[3]<=6'b000000;
        REG_FILE[4]<=6'b000000;
        REG_FILE[5]<=6'b000000;
        REG_FILE[6]<=6'b000000;
        REG_FILE[7]<=6'b000000;
    end
    else
    begin
        if(we)  REG_FILE[wa]<=wd;
    end
endmodule
