`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2026 01:28:55 PM
// Design Name: 
// Module Name: instr_decode
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


module instr_decode(
        input [31:0] instr,
        output wire [6:0] opcode,
        output wire [4:0] rs1,rs2,rd,
        output wire [2:0] funct3,
        output wire [6:0] funct7,
        output reg [31:0] imm
    );
        assign opcode=instr[6:0];
        assign rd=instr[11:7];   
        assign funct3=instr[14:12];
        assign rs1=instr[19:15];
        assign rs2=instr[24:20];
        assign funct7=instr[31:25];
//        always @(*) begin
//             $display("instr=%b opcode=%b", instr, opcode);
//         end
        always@(*) begin        
            imm=32'b0;                           //ADD,SUB (R-Type)
            case(opcode)
                7'b0010011: 
                    if(funct3 == 3'b001 || funct3 == 3'b101)  // SLLI, SRLI, SRAI
                        imm = {27'b0, instr[24:20]};
                    else
                        imm = {{20{instr[31]}}, instr[31:20]};
                7'b0110111: imm = {instr[31:12], 12'b0};  //U-Type LUI
                7'b0010111: imm = {instr[31:12], 12'b0};  //AUIPC
                7'b0000011: imm={{20{instr[31]}},instr[31:20]}; // LW (I-Type)
                7'b0100011: imm={{20{instr[31]}},instr[31:25],instr[11:7]}; //SW (S-Type)
                7'b1100011: imm={{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0}; // Branch (SB-Type)
                7'b1101111: imm={{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0}; //JAL(UJ-Type)
                7'b1100111: imm={{20{instr[31]}},instr[31:20]}; //JALR(I-Type)
            endcase;
        end
        always @(*) begin
             $display("imm=%b", imm);
         end
            
        
endmodule