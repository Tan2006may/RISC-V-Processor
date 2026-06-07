`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 11:43:36 AM
// Design Name: 
// Module Name: Mem
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


   module Mem(
            input clk,
            input [31:0] alu_res,
            input [31:0] mux2_data,
            input MemWrite, MemRead,
            output reg [31:0] Read_Data
        );
      reg [31:0] dataMem[0:31];
            integer i;
            
            `ifndef SYNTHESIS
            initial begin
               for(i = 0; i < 32; i = i + 1) begin
                    dataMem[i] = 32'd0;
                end
            end
            `endif

            always@(posedge clk) begin
                if(MemRead && MemWrite)
                    $display("ERROR: MemRead and MemWrite are both high");  
                else if(MemWrite) dataMem[alu_res>>2]<=mux2_data;
            end
            always@(*) begin
                if(MemRead) begin
                    Read_Data=dataMem[alu_res>>2];
                end 
                else Read_Data=32'b0;
            end
endmodule

