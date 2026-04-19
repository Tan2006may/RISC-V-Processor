`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 09:48:24 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
        input [4:0] rs1,rs2,
        input [4:0] rd_EXMEM,rd_MEMWB,
        input RegWrite_EXMEM, RegWrite_MEMWB,
        output reg [1:0] ForwardA,ForwardB
    );
        always@(*) begin
           ForwardA=2'b00;
           ForwardB=2'b00;
           if(rd_EXMEM!=5'd0 && rd_EXMEM==rs1 && RegWrite_EXMEM) ForwardA=2'b10;
           else if(rd_MEMWB!=5'd0 && rd_MEMWB==rs1 && RegWrite_MEMWB) ForwardA=2'b01;
           if(rd_EXMEM!=5'd0 && rd_EXMEM==rs2 && RegWrite_EXMEM) ForwardB=2'b10;
           else if(rd_MEMWB!=5'd0 && rd_MEMWB==rs2 && RegWrite_MEMWB) ForwardB=2'b01;
           $display("ForwardA=%d,ForwardB=%d", ForwardA,ForwardB);
       end  
endmodule
