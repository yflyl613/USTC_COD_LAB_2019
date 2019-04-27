`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/24 10:11:29
// Design Name: 
// Module Name: DIV
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


module DIV #(parameter N=4,W=8)(
    input [N-1:0] x,
    input [N-1:0] y,
    input rst,
    input clk,
    output [N-1:0] q,
    output [N-1:0] r,
    output error,
    output done
    );//00=init,01=shift,10=done
    reg [1:0]state=2'b00,next_state;
    reg [W-1:0]data;
    integer count=N;
    reg finish=0;
    reg fault=0;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst) state <= 2'b00;
        else  state <= next_state;
    end
    
     always @(state or count or fault)
     begin
         if(fault) next_state = 2'b10;
         else case(state)
         2'b00: next_state = 2'b01;
         2'b01: if(count==1)    next_state = 2'b10;
                else next_state = 2'b01;
         2'b10: next_state = 2'b10;
         endcase
     end
     
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            count <= N;
            fault <= 0;
            data<=8'b0000_0000;
        end
        else
        case(state)
         2'b00:begin
                    count <= N;
                    if(~(y[0]|y[1]|y[2]|y[3]))  fault <= 1;
                    else    data <= {4'b0000,x};
                end
         2'b01: begin
                    data = data << 1;
                    count<=count -1;
                    if(data[W-1:N]>=y)
                    begin
                        data[0] = 1'b1;
                        data[W-1:N] = data[W-1:N] - y;
                    end
               end
         2'b10:;
      endcase
    end
    
    always @(state)
    begin
        case(state)
        2'b00: finish = 0;
        2'b01: finish = 0;
        2'b10: finish = 1;
        endcase
    end
    
    assign error = fault;
    assign done = fault ? 1'b0 : finish;
    assign q = fault ? 4'b0000 : data[N-1:0];
    assign r = fault ? 4'b0000 : data[W-1:N];
endmodule
