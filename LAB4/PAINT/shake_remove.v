`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 23:08:43
// Design Name: 
// Module Name: signal_process
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


module shake_remove(
    input clk_100M,
	input in,
	output reg out
);
    localparam SAMPLE_TIME = 1000000;
    integer cnt=0;

    always @(posedge clk_100M)
    begin
        if(in)  cnt<=cnt+1;
        else cnt<=0;
    end
     
    always @(cnt)
    begin
        if(cnt >= SAMPLE_TIME)    out=1;
        else out=0;
    end 
endmodule
