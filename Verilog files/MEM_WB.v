`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 06:53:26 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
        input clk,flush,rst,
        input [1:0] MemtoReg,
        input RegWrite,
        input [31:0] read_data,alu_res,pc_plus4_MEM,
        input [4:0] rd,
        output reg [1:0] fwdMemtoReg,
        output reg fwdRegWrite,
        output reg [31:0] fwdread_data,fwdalu_res,pc_plus4_WB,
        output reg [4:0] fwdrd 
    );  
        always@(posedge clk) begin
            if(flush || rst) begin
                fwdMemtoReg <= 1'b0;
                fwdRegWrite <= 1'b0;
                fwdread_data <= 32'b0;
                fwdalu_res <= 32'b0;
                fwdrd <= 5'b0;
                pc_plus4_WB <= 32'b0;
             end
             else begin
                fwdMemtoReg <= MemtoReg;
                fwdRegWrite <= RegWrite;
                fwdread_data <= read_data;
                fwdalu_res <= alu_res;
                fwdrd <= rd;
                pc_plus4_WB <= pc_plus4_MEM;
             end
       end
endmodule
