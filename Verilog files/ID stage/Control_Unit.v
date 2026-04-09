`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2026 12:34:23 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
        input wire [6:0] opcode,
        input stall,
        output reg[3:0] ALUOp,
        output reg [1:0] MemtoReg,
        output reg ALUSrc,MemWrite,MemRead,RegWrite,Branch,jal,jalr
    );
        always@(*) begin
            ALUOp=4'd0;
            ALUSrc=1'b0;
            MemWrite=1'b0;
            MemRead=1'b0;
            MemtoReg=2'b00;
            RegWrite=1'b0;
            Branch=1'b0;
            jal=1'b0;
            jalr=1'b0;
            if(!stall)begin
                case(opcode)
                    7'b0110011:begin //R-TYPE
                        ALUOp=4'd0;
                        RegWrite=1'b1;
                    end
                    7'b0000011:begin //LW
                        ALUOp=4'd1;
                        MemtoReg=2'd1;
                        RegWrite=1'b1;
                        MemRead=1'b1;
                        ALUSrc=1'b1;
                    end
                    7'b0010011:begin //I-Type
                        ALUOp=4'd2;
                        ALUSrc=1'b1;
                        RegWrite = 1'b1;
                    end
                    7'b1100111:begin //JALR
                        ALUOp=4'd3;
                        ALUSrc = 1'b1;
                        RegWrite=1'b1;
                        MemtoReg=2'd2;
                        jalr=1;
                    end
                    7'b0100011:begin //SW
                        ALUOp=4'd4;
                        MemWrite=1'b1;
                        ALUSrc=1'b1;
                    end
                    7'b1100011:begin //BRANCH
                        ALUOp=4'd5; 
                        Branch=1'b1;
                    end
                    7'b0110111:begin //LUI
                        ALUSrc = 1'b1;
                        ALUOp=4'd6;
                        RegWrite=1;
                    end
                    7'b1101111:begin //JAL
                        ALUOp=4'd7;
                        RegWrite=1'b1;
                        MemtoReg=2'd2;
                        jal=1;
                    end
                    7'b0010111:begin //AUIPC
                        ALUOp=4'd8;
                        ALUSrc = 1'b1;
                        RegWrite=1'b1;
                        MemtoReg=2'd3;
                    end
                 endcase;
            end       
        end
//        always @(*) begin
//             $display("RegWrite=%b", RegWrite);
//         end
endmodule
