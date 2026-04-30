`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 11:18:26 PM
// Design Name: 
// Module Name: Top
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


module Top(
        input clk,rst
    );
        //IF Stage
        wire [31:0] pc_IF,nxt_pc,pc_plus4_IF,instr_ID, pc_ID,pc_plus4_ID,pc_plus4_EX,pc_plus4_MEM,pc_plus4_WB;
        wire [31:0] instr;
        wire stall,flush;
        
        pc_adder PA(
            .pc(pc_IF),
            .pc_plus4(pc_plus4_IF)
            );
            
        pc PC(
            .clk(clk),
            .rst(rst),
            .stall(stall),
            .nxt_pc(nxt_pc),
            .new_pc(pc_IF)
            );
       
       instr_mem IM(
            .pc(pc_IF),
            .instr(instr)
            );
       
        IF_ID IF_ID(
            .rst(rst),
            .clk(clk),
            .flush(flush),
            .stall(stall),
            .instr(instr),
            .pc(pc_IF),.pc_plus4_IF(pc_plus4_IF),
            .fwdInstr(instr_ID),
            .fwdpc(pc_ID), .pc_plus4_ID(pc_plus4_ID)
            );
            
       //ID Stage
        wire [6:0] op;
        wire [31:0] rs1_val, rs2_val,imm,rs1_val_EX, rs2_val_EX,imm_EX,pc_EX,write_data;
        wire [4:0] rs1,rs2,rd,rs1_EX,rs2_EX,rd_EX,rd_MEM;
        wire [3:0] ALUOp,ALUOp_EX;
        wire [1:0] MemtoReg,MemtoReg_EX;
        wire ALUSrc,MemWrite,MemRead,Branch,jal,jalr,RegWrite,ALUSrc_EX,MemWrite_EX,MemRead_EX,Branch_EX,jal_EX,jalr_EX,RegWrite_EX,RegWrite_WB;
        wire [2:0] funct3,funct3_EX;
        wire [6:0] funct7,funct7_EX;
        
        instr_decode ID(
            .instr(instr_ID),
            .opcode(op),
            .rs1(rs1),.rs2(rs2),.rd(rd),
            .funct3(funct3),
            .funct7(funct7),
            .imm(imm)
           );
       
        Reg_file RF(
            .clk(clk),
            .rst(rst),
            .rs1(rs1),.rs2(rs2),.rd(rd_WB),
            .regWrite(RegWrite_WB),
            .write_data(write_data),
            .rs1_val(rs1_val),
            .rs2_val(rs2_val)
            );
            
        Control_Unit CU(
            .opcode(op),
            .stall(stall),
            .ALUOp(ALUOp),
            .MemtoReg(MemtoReg),
            .ALUSrc(ALUSrc),.MemWrite(MemWrite),.MemRead(MemRead),.RegWrite(RegWrite),.Branch(Branch),.jal(jal),.jalr(jalr)
            );
        
        Hazard_det_Unit HDU(
            .MemtoReg(MemtoReg_EX),
            .rd_IDEX(rd_EX),.rs1_IFID(rs1),.rs2_IFID(rs2),
            .stall(stall)
            );
            
        ID_EX ID_EX(
            .rst(rst),
            .stall(stall),
            .clk(clk),.flush(flush),
            .rs1_val(rs1_val), .rs2_val(rs2_val),.imm(imm),.pc(pc_ID),
            .rs1(rs1),.rs2(rs2),.rd(rd),
            .ALUOp(ALUOp),
            .MemtoReg(MemtoReg),
            .ALUSrc(ALUSrc),.MemWrite(MemWrite),.MemRead(MemRead),.RegWrite(RegWrite),.Branch(Branch),.jal(jal),.jalr(jalr),
            .funct3(funct3),
            .funct7(funct7),
            .fwdrs1(rs1_EX),.fwdrs2(rs2_EX),.fwdrd(rd_EX),
            .fwdimm(imm_EX),.fwdrs1_val(rs1_val_EX),.fwdrs2_val(rs2_val_EX),.fwdpc(pc_EX),
            .fwdfunct3(funct3_EX),
            .fwdfunct7(funct7_EX),
            .fwdALUOp(ALUOp_EX),
            .fwdMemtoReg(MemtoReg_EX),
            .pc_plus4_ID(pc_plus4_ID),
            .pc_plus4_EX(pc_plus4_EX),
            .fwdALUSrc(ALUSrc_EX),.fwdMemWrite(MemWrite_EX),.fwdMemRead(MemRead_EX),.fwdBranch(Branch_EX),.fwdjal(jal_EX),.fwdjalr(jalr_EX),.fwdRegWrite(RegWrite_EX)
            );
            
            
         //EX Stage
         wire [31:0] pc_target, alu_res, alu_res_MEM, pc_MEM,mux2_data_MEM;
         wire [31:0] val1,val2;
         wire [3:0] operation;
         wire [2:0] branchType;
         wire flag;
         wire [1:0] ForwardA, ForwardB;
         wire [4:0] rd_WB;
         wire MemWrite_MEM,MemRead_MEM,RegWrite_MEM;
         wire [1:0] MemtoReg_MEM;
         wire [31:0] mux1_data,mux2_data;
         
           pc_target_adder PTA(
            .pc_EX(pc_EX),.imm_EX(imm_EX),
            .pc_target(pc_target)
            );
            
           Forwarding_Unit FU(
                .rs1(rs1_EX),.rs2(rs2_EX),
                .rd_EXMEM(rd_MEM),.rd_MEMWB(rd_WB),
                .RegWrite_EXMEM(RegWrite_MEM), .RegWrite_MEMWB(RegWrite_WB),
                .ForwardA(ForwardA),.ForwardB(ForwardB)
                );
                
           Mux MUX(
                .write_data(write_data),.rs1_val_EX(rs1_val_EX),.rs2_val_EX(rs2_val_EX), .alu_res_MEM(alu_res_MEM),
                .ForwardA(ForwardA), .ForwardB(ForwardB),
                .mux1_data(mux1_data), .mux2_data(mux2_data)
                );
                
           ALU_Control ALUC(
                .ALUsrc(ALUSrc_EX),
                .ALUOp(ALUOp_EX),
                .funct3(funct3_EX),
                .funct7(funct7_EX),
                .imm(imm_EX),.mux1_data(mux1_data),.mux2_data(mux2_data),
                .val1(val1),
                .val2(val2),
                .op(operation),
                .branchType(branchType)
                );
           
           ALU ALU(
                .op(operation),
                .val1(val1),
                .val2(val2),
                .branchType(branchType),
                .result(alu_res),
                .flag(flag)
                );
            
            assign flush =
                ((Branch_EX && flag) || jal_EX || jalr_EX);
             
             always @(*) begin
             $display("pc_IF=%d, pc_ID=%d,pc_EX=%d,imm=%d", pc_IF,pc_ID,pc_EX,imm_EX);
            end
             assign nxt_pc =    
                ((Branch_EX && flag) || jal_EX) ? pc_target :
                (jalr_EX) ? (alu_res & ~1) : 
                pc_plus4_IF;
            
            EX_MEM EX_MEM(
                .rst(rst),
                .clk(clk),.flush(flush),
                .alu_res(alu_res),.mux2_data(mux2_data),
                .rd(rd_EX),
                .MemWrite(MemWrite_EX),.MemRead(MemRead_EX),.RegWrite(RegWrite_EX),
                .MemtoReg(MemtoReg_EX),
                .fwdalu_res(alu_res_MEM),.fwdmux2_val(mux2_data_MEM),
                .fwdrd(rd_MEM),
                .fwdMemWrite(MemWrite_MEM),.fwdMemRead(MemRead_MEM),.fwdRegWrite(RegWrite_MEM),
                .fwdMemtoReg(MemtoReg_MEM),
                .pc_plus4_EX(pc_plus4_EX),
                .pc_plus4_MEM(pc_plus4_MEM)
                );
                
              
            //MEM Stage
            wire [31:0] Read_Data,Read_Data_WB,alu_res_WB;
            wire [1:0] MemtoReg_WB;
            Mem MEM(
                .clk(clk),   
                .alu_res(alu_res_MEM),
                .mux2_data(mux2_data_MEM),
                .MemWrite(MemWrite_MEM), .MemRead(MemRead_MEM),
                .Read_Data(Read_Data)
                );
             
            MEM_WB MEM_WB(
                .rst(rst),
                .clk(clk),.flush(flush),
                .MemtoReg(MemtoReg_MEM),
                .RegWrite(RegWrite_MEM),
                .read_data(Read_Data),.alu_res(alu_res_MEM),
                .rd(rd_MEM),
                .fwdMemtoReg(MemtoReg_WB),
                .fwdRegWrite(RegWrite_WB),
                .fwdread_data(Read_Data_WB),.fwdalu_res(alu_res_WB),
                .fwdrd(rd_WB),
                .pc_plus4_MEM(pc_plus4_MEM),
                .pc_plus4_WB(pc_plus4_WB)
                );
                    
        assign write_data =
        (MemtoReg_WB == 2'b00) ? alu_res_WB : //Arithm
        (MemtoReg_WB == 2'b01) ? Read_Data_WB : //LW
        (MemtoReg_WB == 2'b10) ? pc_plus4_WB : //JAL and AUIPC
                                 (alu_res+pc_EX);
        
            
endmodule
