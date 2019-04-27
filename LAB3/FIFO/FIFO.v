`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/30 23:35:23
// Design Name: 
// Module Name: FIFO
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


module FIFO(
    input en_in,en_out,rst,clk,
    input [3:0]in,
    output reg [3:0]out,
    output full,
    output empty,
    output reg [15:0]display    //[7:0]an,[15:8]seg
    );
    
    reg [3:0]queue[7:0];
    reg [2:0]front=3'b000,rear=3'b000;
    reg clk_8k=0;
    integer count=0,display_cnt=0,num=0;
    wire [7:0]seg0,seg1,seg2,seg3,seg4,seg5,seg6,seg7;
    wire in_enable,out_enable,rst_enable;
    
    pulse p1(.clk(clk),.in(en_in),.pulse(in_enable));
    pulse p2(.clk(clk),.in(en_out),.pulse(out_enable));
    
    initial
    begin
            queue[0]<=4'b1111;
            queue[1]<=4'b1111;
            queue[2]<=4'b1111;
            queue[3]<=4'b1111;
            queue[4]<=4'b1111;
            queue[5]<=4'b1111;
            queue[6]<=4'b1111;
            queue[7]<=4'b1111;
    end
        
    assign full=(num==8);
    assign empty=(num==0);
    
    bcdto7segment b0(.x(queue[0]),.front(front),.num(3'b000),.seg(seg0));
    bcdto7segment b1(.x(queue[1]),.front(front),.num(3'b001),.seg(seg1));
    bcdto7segment b2(.x(queue[2]),.front(front),.num(3'b010),.seg(seg2));
    bcdto7segment b3(.x(queue[3]),.front(front),.num(3'b011),.seg(seg3));
    bcdto7segment b4(.x(queue[4]),.front(front),.num(3'b100),.seg(seg4));
    bcdto7segment b5(.x(queue[5]),.front(front),.num(3'b101),.seg(seg5));
    bcdto7segment b6(.x(queue[6]),.front(front),.num(3'b110),.seg(seg6));
    bcdto7segment b7(.x(queue[7]),.front(front),.num(3'b111),.seg(seg7));
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            front<=0;
            rear<=0;
            num<=0;
            out<=0;
            queue[0]<=4'b1111;
            queue[1]<=4'b1111;
            queue[2]<=4'b1111;
            queue[3]<=4'b1111;
            queue[4]<=4'b1111;
            queue[5]<=4'b1111;
            queue[6]<=4'b1111;
            queue[7]<=4'b1111;
        end
        else    
        begin
            if(in_enable)
            begin
                if(~full)
                begin
                    queue[rear]<=in;
                    rear<=(rear+1)>=8?rear-7:rear+1;
                    num<=num+1;
                end
           end
           else if(out_enable)
           begin 
                if(~empty)
                begin
                    out<=queue[front];
                    queue[front]<=4'b1111;  
                    front<=(front+1)>=8?front-7:front+1;
                    num<=num-1;
               end
             end
        end
    end
    
    always @(negedge clk)    //clk div
    begin
            if(count>=6249)
            begin
                count<=0;
                clk_8k<=~clk_8k;
            end
            else    count<=count+1;
    end
    
    always @(posedge clk_8k)        //display control
    begin
        if(display_cnt>=8) display_cnt<=0;
        else display_cnt<=display_cnt+1;
    end
    
    always @(posedge clk_8k)
    begin
        if(display_cnt==0)
        begin
            display[7:0]<=8'b0111_1111;
            display[15:8]<=seg0;
        end
        else if(display_cnt==1)
        begin
            display[7:0]<=8'b1011_1111;
            display[15:8]<=seg1;
        end
        else if(display_cnt==2)
        begin
            display[7:0]<=8'b1101_1111;
            display[15:8]<=seg2;
        end
        else if(display_cnt==3)
        begin
            display[7:0]<=8'b1110_1111;
            display[15:8]<=seg3;
        end
        else if(display_cnt==4)
        begin
            display[7:0]<=8'b1111_0111;
            display[15:8]<=seg4;
        end
        else if(display_cnt==5)
        begin
            display[7:0]<=8'b1111_1011;
            display[15:8]<=seg5;
        end
        else if(display_cnt==6)
        begin
            display[7:0]<=8'b1111_1101;
            display[15:8]<=seg6;
        end
        else
        begin
            display[7:0]<=8'b1111_1110;
            display[15:8]<=seg7;
        end
    end
endmodule
