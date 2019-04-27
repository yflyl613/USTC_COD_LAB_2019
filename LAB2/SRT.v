`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 09:29:21
// Design Name: 
// Module Name: SRT
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
module SRT(
    input [3:0] x0,
    input [3:0] x1,
    input [3:0] x2,
    input [3:0] x3,
    input rst,
    input clk,
    output [3:0] s0,
    output [3:0] s1,
    output [3:0] s2,
    output [3:0] s3,
    output done
    );
    reg a0=0,a1=0,a2=0;
    reg b0=0,b1=0,b2=0;
    reg c0=0,c1=0,c2=0;
    reg d0=0,d1=0,d2=0;
    reg [1:0]mid0=2'b00,mid1=2'b00,mid2=2'b00,mid3=2'b00;
    reg [3:0]out[3:0];
    reg finish;
    reg [1:0]state=2'b00,next_state;
    
    always @(posedge clk or posedge rst)
        if(rst)  state<=2'b00;
        else state<=next_state;
    
    always @(state)
        case(state)
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b10;
        endcase
        
    always @(posedge clk or posedge rst)
    if(rst)
        begin
            {a0,a1,a2}<=3'b000;
            {b0,b1,b2}<=3'b000;
            {c0,c1,c2}<=3'b000;
            {d0,d1,d2}<=3'b000;
            {mid0,mid1,mid2,mid3}<=8'b0000_0000;
            {out[0],out[1],out[2],out[3]}<=16'b0000_0000_0000_0000;
            finish<=0;
        end
    else
    case(state)
        2'b00:begin
            finish<=0;
            out[0]<=x0; out[1]<=x1; out[2]<=x2; out[3]<=x3;
            if(x0>x1) a0<=1'b1;
            else a0<=1'b0;
            if(x0>x2) a1<=1'b1;
            else a1<=1'b0;
            if(x0>x3) a2<=1'b1;
            else a2<=1'b0;
            
            if(x1>=x0) b0<=1'b1;
            else b0<=1'b0;
            if(x1>x2) b1<=1'b1;
            else b1<=1'b0;
            if(x1>x3) b2<=1'b1;
            else b2<=1'b0;
        
            if(x2>=x0) c0<=1'b1;
            else c0<=1'b0;
            if(x2>=x1) c1<=1'b1;
            else c1<=1'b0;
            if(x2>x3) c2<=1'b1;
            else c2<=1'b0;
             
            if(x3>=x0) d0<=1'b1;
            else d0<=1'b0;
            if(x3>=x1) d1<=1'b1;
            else d1<=1'b0;
            if(x3>=x2) d2<=1'b1;
            else d2<=1'b0;
        end
        2'b01:begin
            finish<=0;
            out[0]<=x0; out[1]<=x1; out[2]<=x2; out[3]<=x3; 
            mid0<=a0+a1+a2;
            mid1<=b0+b1+b2;
            mid2<=c0+c1+c2;
            mid3<=d0+d1+d2;
        end
       2'b10:begin
           finish<=1;
           out[mid0]<=x0;
           out[mid1]<=x1;
           out[mid2]<=x2;
           out[mid3]<=x3;
        end
endcase
    assign s0 = out[0];
    assign s1 = out[1];
    assign s2 = out[2];
    assign s3 = out[3];
    assign done = finish;
endmodule
/*
    reg [2:0]state=3'b000,next_state;
    reg [3:0]data_0,data_1,data_2,data_3;
    reg finish=0;
   
    task CMP;
        inout [3:0]x,y;
        reg [3:0]tmp;
        reg [3:0]y,f;
        if(x<y)
        begin
            tmp=x;  x=y; y=tmp;
        end
    endtask
    
    always @(posedge clk or posedge rst)
    begin
        if(rst) state<=3'b000;
        else state<=next_state;
    end
    
    always @(state)
    begin
        case(state)
        3'b000:next_state=3'b001;
        3'b001:next_state=3'b010;
        3'b010:next_state=3'b011;
        3'b011:next_state=3'b100;
        3'b100:next_state=3'b100;
        endcase
    end   
    
    always@(posedge clk or posedge rst)
    if(rst)
        begin
            data_0<=4'b0000;
            data_1<=4'b0000;
            data_2<=4'b0000;
            data_3<=4'b0000;
            finish<=0;
        end
    else
        begin
        case(state)
        3'b000:begin
                    data_0<=x0;
                    data_1<=x1;
                    data_2<=x2;
                    data_3<=x3;
               end
        3'b001:begin
                    CMP(data_0,data_2);
                    CMP(data_1,data_3);
               end
        3'b010:begin
                    CMP(data_0,data_1);
                    CMP(data_2,data_3);
               end
        3'b011:CMP(data_1,data_2);
        3'b100:finish<=1;        
        endcase
    end
     assign done=finish; 
     assign s0=data_0;
     assign s1=data_1;
     assign s2=data_2;
     assign s3=data_3;
endmodule*/
