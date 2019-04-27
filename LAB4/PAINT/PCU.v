`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 20:36:22
// Design Name: 
// Module Name: PCU
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


module PCU(
    input [11:0]rgb,
    input [3:0]dir,
    input draw,
    input clk_100M,
    input rst,
    output reg [15:0]addr,
    output reg [11:0]pdata,
    output we,
    output [7:0]x,y
    );
    
    reg [7:0]x_pos,y_pos;
    wire [3:0]DIR;  //DIR[0]==left,DIR[1]=right,DIR[2]=up,DIR[3]=down
    integer cnt=0,cnt2=0,cnt_rst=0;
    
    initial
    begin
        x_pos <= 128;
        y_pos <= 128;
    end
   
    shake_remove s0(.in(dir[0]),.clk_100M(clk_100M),.out(DIR[0]));
    shake_remove s1(.in(dir[1]),.clk_100M(clk_100M),.out(DIR[1]));
    shake_remove s2(.in(dir[2]),.clk_100M(clk_100M),.out(DIR[2]));
    shake_remove s3(.in(dir[3]),.clk_100M(clk_100M),.out(DIR[3]));
    
    localparam KEEP_TIME=25000000;
    localparam init=5'b00000;
    localparam up_cnting=5'b00001,up_incr=5'b00010;
    localparam down_cnting=5'b00011,down_incr=5'b00100;
    localparam left_cnting=5'b00101,left_incr=5'b00110;
    localparam right_cnting='b00111,right_incr=5'b01000;
    localparam up_left_cnting=5'b01001,up_left_incr=5'b01010;
    localparam up_right_cnting=5'b01011,up_right_incr=5'b01100;
    localparam down_left_cnting=5'b01101,down_left_incr=5'b01110;
    localparam down_right_cnting=5'b01111,down_right_incr=5'b10000;
    localparam clean=5'b10001;
    
    reg [4:0]state=5'b0000;
    
    always @(posedge clk_100M)
    case(state)
        init:if(rst)  state<=clean;
             else if(DIR[0])    state<=left_cnting;
             else if(DIR[1])    state<=right_cnting;
             else if(DIR[2])    state<=up_cnting;
             else if(DIR[3])    state<=down_cnting;
             else      state<=init;
        
        clean:if(cnt_rst<=65535 && rst)  state<=clean;
              else  state<=init;
        
        left_cnting: if(cnt<KEEP_TIME&&DIR[2]) state<=up_left_cnting;
                     else if(cnt<KEEP_TIME&&DIR[3])  state<=down_left_cnting;
                     else if(cnt<KEEP_TIME&&DIR[0])  state<=left_cnting;
                     else if(~DIR[0])    state<=init;
                     else   state<=left_incr;
        left_incr:if(DIR[0])  state<=left_cnting;
                  else state<=init;      
        
        right_cnting:if(cnt<KEEP_TIME&&DIR[2]) state<=up_right_cnting;
                     else if(cnt<KEEP_TIME&&DIR[3])  state<=down_right_cnting;
                     else if(cnt<KEEP_TIME&&DIR[1])  state<=right_cnting;
                     else if(~DIR[1])    state<=init;
                     else state<=right_incr;
        right_incr:if(DIR[1])  state<=right_cnting;
                   else state<=init;
        
        up_cnting: if(cnt<KEEP_TIME&&DIR[0]) state<=up_left_cnting;
                   else if(cnt<KEEP_TIME&&DIR[1])  state<=up_right_cnting;
                   else if(cnt<KEEP_TIME&&DIR[2])  state<=up_cnting;
                   else if(~DIR[2])    state<=init;
                   else state<=up_incr;
        up_incr:if(DIR[2])  state<=up_cnting;
                else state<=init;
                
        down_cnting: if(cnt<KEEP_TIME&&DIR[0]) state<=down_left_cnting;
                     else if(cnt<KEEP_TIME&&DIR[1])  state<=down_right_cnting;
                     else if(cnt<KEEP_TIME&&DIR[3])  state<=down_cnting;
                     else if(~DIR[3])    state<=init;
                     else state<=down_incr;
        down_incr:if(DIR[3])  state<=down_cnting;
                  else state<=init;
                          
        up_left_cnting:if(cnt2<KEEP_TIME&&DIR[0]&&DIR[2])    state<=up_left_cnting;
                       else if(~DIR[0]||~DIR[2])  state<=init;
                       else state<=up_left_incr;
        up_left_incr:if(DIR[0]&&DIR[2]) state<=up_left_cnting;
                     else   state<=init;
                     
        up_right_cnting:if(cnt2<KEEP_TIME&&DIR[1]&&DIR[2])    state<=up_right_cnting;
                        else if(~DIR[1]||~DIR[2])  state<=init;
                        else state<=up_right_incr;
        up_right_incr:if(DIR[1]&&DIR[2]) state<=up_right_cnting;
                      else   state<=init;
                      
        down_left_cnting:if(cnt2<KEEP_TIME&&DIR[0]&&DIR[3])    state<=down_left_cnting;
                         else if(~DIR[0]||~DIR[3])  state<=init;
                         else   state<=down_left_incr;
        down_left_incr:if(DIR[0]&&DIR[3]) state<=down_left_cnting;
                       else   state<=init;
                                               
        down_right_cnting:if(cnt2<KEEP_TIME&&DIR[1]&&DIR[3])    state<=down_right_cnting;
                          else if(~DIR[1]||~DIR[3])  state<=init;
                          else state<=down_right_incr;
        down_right_incr:if(DIR[1]&&DIR[3]) state<=down_right_cnting;
                        else   state<=init;
                                                 
        endcase
    
    always @(posedge clk_100M)
    case(state)
        init:begin
                cnt<=0;
                cnt2<=0;
                cnt_rst<=0;
             end
        
        clean:begin
                x_pos<=128;
                y_pos<=128;
                cnt_rst<=cnt_rst+1;
               end
           
        left_cnting:cnt<=cnt+1;
        left_incr:begin
                    cnt<=0;
                    if(x_pos==0) x_pos<=0;
                    else x_pos<=x_pos-1;
                  end
        
        right_cnting:cnt<=cnt+1;
        right_incr:begin
                    cnt<=0;
                    if(x_pos==255) x_pos<=255;
                    else   x_pos<=x_pos+1;
                   end
                             
        up_cnting:cnt<=cnt+1;
        up_incr:begin
                    cnt<=0;
                    if(y_pos==0) y_pos<=0;
                    else y_pos<=y_pos-1;
                end
                
        down_cnting:cnt<=cnt+1;
        down_incr:begin
                    cnt<=0;
                    if(y_pos==255)  y_pos<=255;
                    else    y_pos<=y_pos+1;
                  end
                  
        up_left_cnting:begin
                            cnt<=0;
                            cnt2<=cnt2+1;
                       end
        up_left_incr:begin
                            cnt2<=0;
                            if(x_pos==0) x_pos<=0;
                            else x_pos<=x_pos-1;
                            if(y_pos==0) y_pos<=0;
                            else y_pos<=y_pos-1;   
                     end
          
         up_right_cnting:begin
                            cnt<=0;
                            cnt2<=cnt2+1;
                          end
         up_right_incr:begin
                            cnt2<=0;
                            if(x_pos==255) x_pos<=255;
                            else x_pos<=x_pos+1;
                            if(y_pos==0) y_pos<=0;
                            else y_pos<=y_pos-1;   
                        end                           
        
        down_left_cnting:begin
                             cnt<=0;
                             cnt2<=cnt2+1;
                         end
        down_left_incr:begin
                             cnt2<=0;
                             if(x_pos==0) x_pos<=0;
                             else x_pos<=x_pos-1;
                             if(y_pos==255) y_pos<=255;
                             else y_pos<=y_pos+1;   
                        end
         
         down_right_cnting:begin
                             cnt<=0;
                             cnt2<=cnt2+1;
                           end
         down_right_incr:begin
                             cnt2<=0;
                             if(x_pos==255) x_pos<=255;
                             else x_pos<=x_pos+1;
                             if(y_pos==255) y_pos<=255;
                             else y_pos<=y_pos+1;   
                          end
    endcase
                            
    assign x = x_pos;
    assign y = y_pos;
    assign we = draw;
    
    always @(posedge clk_100M)
    begin
        if(rst)
        begin
            pdata <= 12'b1111_1111_1111;
            addr <= cnt_rst;
        end
        else if(draw)
        begin
            pdata <= rgb;
            addr <= y_pos * 256 + x_pos;
        end
    end
    
endmodule
