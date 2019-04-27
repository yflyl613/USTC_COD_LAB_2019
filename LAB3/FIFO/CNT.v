`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/30 11:25:57
// Design Name: 
// Module Name: CNT
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


module CNT #(parameter N=14)(
    input [N-1:0]d,
    input ce,pe,rst,clk,
    output reg [N-1:0]q
    );
    integer count=0;
    wire clk_1;
    reg clk1=0;
    assign clk_1=clk1;
    always @(negedge clk or posedge rst)
    begin
        if(rst)
        begin
            clk1<=0;
            count<=0;
        end
        else 
        begin
            if(count>=49999999)
            begin
                count<=0;
                clk1=~clk1;
            end
            else count<=count+1;
       end
    end  
    
    always @(posedge clk_1 or posedge rst)
    begin
        if(rst)
        begin
            q<=14'b0000_0000_0000_00;
        end
        else
        begin
            if(pe)  q<=d;
            else if(ce) q<=q+1;
        end
    end                    

endmodule
