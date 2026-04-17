`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 06:36:30 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
        input clk,flush,rst,
        input [31:0] alu_res,mux2_data,pc_plus4_EX,
        input [4:0] rd,
        input MemWrite,MemRead,RegWrite,
        input [1:0] MemtoReg,
        output reg [31:0] fwdalu_res,fwdmux2_val,pc_plus4_MEM,
        output reg [4:0] fwdrd,
        output reg fwdMemWrite,fwdMemRead,fwdRegWrite,
        output reg [1:0] fwdMemtoReg
    );
        always@(posedge clk) begin
            if(flush || rst) begin
                fwdalu_res   <= 32'b0;
                fwdmux2_val   <= 32'b0;
                fwdrd        <= 5'b0;
                fwdMemWrite <= 1'b0;
                fwdMemRead <= 1'b0;
                fwdRegWrite <= 1'b0;
                fwdMemtoReg <= 2'b0;
                pc_plus4_MEM <= 32'b0;
            end
            else begin
                fwdalu_res <= alu_res;
                fwdmux2_val <= mux2_data;
                fwdrd <= rd;
                fwdMemWrite <= MemWrite;
                fwdMemRead <= MemRead;
                fwdRegWrite <= RegWrite;
                fwdMemtoReg <= MemtoReg;
                pc_plus4_MEM <= pc_plus4_EX;
            end
       end
endmodule
