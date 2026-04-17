`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 09:30:05 AM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
        input clk,flush,stall,rst,
        input [31:0] instr,pc,pc_plus4_IF,
        output reg[31:0] fwdInstr, fwdpc, pc_plus4_ID
    );
        always@(posedge clk) begin
            if(flush || rst)begin
                fwdInstr<=32'b0;
                fwdpc<=32'b0;
                pc_plus4_ID<=32'b0;
             end
            else if(!stall)begin
                fwdInstr<=instr;
                fwdpc<=pc;
                pc_plus4_ID<=pc_plus4_IF;
            end
        end
endmodule
