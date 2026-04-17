`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 11:55:52 AM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
        input clk,flush,rst,stall,
        input [31:0] rs1_val, rs2_val,imm,pc,pc_plus4_ID,
        input [4:0] rs1,rs2,rd,
        input [3:0] ALUOp,
        input [1:0] MemtoReg,
        input ALUSrc,MemWrite,MemRead,Branch,jal,jalr,RegWrite,
        input [2:0] funct3,
        input [6:0] funct7,
        output reg [4:0] fwdrs1,fwdrs2,fwdrd,
        output reg [31:0] fwdimm,fwdrs1_val,fwdrs2_val,fwdpc,pc_plus4_EX,
        output reg [2:0] fwdfunct3,
        output reg [6:0] fwdfunct7,
        output reg [3:0] fwdALUOp,
        output reg [1:0] fwdMemtoReg,
        output reg fwdALUSrc,fwdMemWrite,fwdMemRead,fwdBranch,fwdjal,fwdjalr,fwdRegWrite
    );
        always@(posedge clk) begin
            if (flush || rst) begin
                fwdrs1_val<=32'b0;
                fwdrs2_val<=32'b0;
                fwdimm<=32'b0;
                fwdpc<=32'b0;
                fwdrs1<=5'b0;
                fwdrs2<=5'b0;
                fwdrd<=5'b0;
                fwdRegWrite <= 1'b0;
                fwdMemWrite <= 1'b0;
                fwdMemRead  <= 1'b0;
                fwdBranch   <= 1'b0;
                fwdjal      <= 1'b0;
                fwdjalr     <= 1'b0;
                fwdMemtoReg <= 2'b0;
                fwdALUSrc   <= 1'b0;
                fwdALUOp    <= 4'b0;
                fwdfunct3   <= 3'b0;
                fwdfunct7   <= 7'b0;
                pc_plus4_EX <= 32'b0;
             end
             else if(stall) begin
                fwdRegWrite <= 1'b0;
                fwdMemWrite <= 1'b0;
                fwdMemRead  <= 1'b0;
                fwdBranch   <= 1'b0;
                fwdjal      <= 1'b0;
                fwdjalr     <= 1'b0;
                fwdMemtoReg <= 2'b0;
             end
             else begin
                fwdrs1_val<=rs1_val;
                fwdrs2_val<=rs2_val;
                fwdimm<=imm;
                fwdpc<=pc;
                fwdrs1<=rs1;
                fwdrs2<=rs2;
                fwdrd<=rd;
                fwdALUOp<=ALUOp;
                fwdMemtoReg<=MemtoReg;
                fwdALUSrc<=ALUSrc;
                fwdMemWrite<=MemWrite;
                fwdMemRead<=MemRead;
                fwdBranch<=Branch;
                fwdjal<=jal;
                fwdjalr<=jalr;
                fwdRegWrite<=RegWrite;
                fwdfunct3<=funct3;
                fwdfunct7<=funct7;
                pc_plus4_EX <= pc_plus4_ID;
            end
         end               
endmodule
