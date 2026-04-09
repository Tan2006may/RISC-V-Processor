`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2026 01:14:31 PM
// Design Name: 
// Module Name: Reg_file
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


module Reg_file(
        input clk,rst,
        input wire [4:0] rs1,rs2,rd, 
        input regWrite,
        input [31:0] write_data,
        output reg [31:0] rs1_val,rs2_val    
    );
        reg [31:0] regFile[31:0];
        integer i;
        always@(*) begin
            if(rs1==5'b00000) rs1_val=32'b0;
            else if(rs1==rd && regWrite) rs1_val=write_data;
            else rs1_val=regFile[rs1];
            
            if(rs2==5'b00000) rs2_val=32'b0;
            else if(rs2==rd && regWrite) rs2_val=write_data; 
            else rs2_val=regFile[rs2];
        end
        
        always@(posedge clk) begin
            if(rst) begin
                for(i=0;i<32;i=i+1)
                    regFile[i]<=32'b0;  
            end
            else if(regWrite && rd!=5'b00000) regFile[rd]<=write_data;
        end
//        always @(*) begin
//           $display("write_data=%d",write_data);
//         end
        
endmodule
