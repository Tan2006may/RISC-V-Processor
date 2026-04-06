`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 08:56:10 PM
// Design Name: 
// Module Name: pc
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


module pc(
        input clk,rst,stall,
        input [31:0] nxt_pc,
        output reg [31:0] new_pc
        );
        always@(posedge clk) begin
            if(rst) new_pc<=0;
            else if(!stall) new_pc<=nxt_pc;
            else if(stall) new_pc<=new_pc;
        end
endmodule
