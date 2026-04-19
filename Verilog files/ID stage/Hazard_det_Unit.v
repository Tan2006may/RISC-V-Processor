`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2026 10:23:21 PM
// Design Name: 
// Module Name: Hazard_det_Unit
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


module Hazard_det_Unit(
        input [1:0] MemtoReg,
        input [4:0] rd_IDEX,rs1_IFID,rs2_IFID,
        output reg stall
    );
        always@(*) begin
            stall=1'b0;
            if(MemtoReg==2'd1) begin
                if(rd_IDEX!=5'd0 && (rd_IDEX==rs1_IFID || rd_IDEX==rs2_IFID)) stall=1'b1;
            end
        end
endmodule
