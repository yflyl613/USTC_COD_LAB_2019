`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/31 19:57:22
// Design Name: 
// Module Name: pulse
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


module pulse(
    input clk,
    input in,
    output reg pulse
    );
    parameter S0=2'b00,S1=2'b01,S2=2'b10;
    reg [1:0]state=S0;
        
    always @(posedge clk)
        case(state)
        S0:begin
            if(in)    state<=S1;
            else state<=S0;
           end
        S1:begin
            if(in)    state<=S2;
            else state<=S0;
            end
        S2:begin
            if(in)    state<=S2;
            else state<=S0;
           end
       endcase
    
    always @(state)
        case(state)
        S0:begin
            pulse=0;
           end
        S1:begin
            pulse=1;
           end
        S2:begin
            pulse=0;
           end
        endcase
endmodule
