`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2026 01:35:35 PM
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
        input wire ALUsrc,
        input wire [3:0] ALUOp,
        input wire [2:0] funct3,
        input wire [6:0] funct7,
        input wire [31:0] imm,mux1_data,mux2_data,
        output reg [31:0] val1,val2,
        output reg [3:0] op,
        output reg [2:0] branchType
    );
//        always @(*) begin
//             $display("rs2=%b", rs2_data);
//         end
        always@(*) begin
            if(ALUsrc==1'b1) val2=imm;
            else val2=mux2_data;
        end
        always@(*) begin
//            $display("funct3=%b", funct3);
            val1=mux1_data;
            op=4'd0;
            if(ALUOp==4'b0000) begin
                if(funct3==3'b000) begin
                    if(funct7==7'b0000000) op=4'd0; //ADD
                    else op=4'd1;                   //SUB
                end
                else if(funct3==3'b001) op=4'd2;         //SLL
                else if(funct3==3'b010) op=4'd3;        //SLT
                else if(funct3==3'b011) op=4'd4;        //SLTU
                else if(funct3==3'b100) op=4'd5;         //XOR
                else if(funct3==3'b101)begin  
                               
                    if(funct7==7'b0000000)op=4'd6;  //SRL
                    else op=4'd7;                   //SRA
                end
                else if(funct3==3'b110) op=4'd8;          //OR
                else if(funct3==3'b111) op=4'd9;          //AND
            end
            
            else if(ALUOp==4'b0001) op=4'd0; //LW
            
            else if(ALUOp==4'b0010)begin
                if(funct3==3'b000) op=4'd0;         //ADDI
                else if(funct3==3'b001) op=4'd2;         //SLLI     
                else if(funct3==3'b010) op=4'd3;        //SLTI
                else if(funct3==3'b011) op=4'd4;        //SLTIU      
                else if(funct3==3'b100) op=4'd5;         //XORI
                else if(funct3==3'b101) begin
                    if(funct7==7'b0000000) op=4'd6; //SRLI
                    else op=4'd7;                   //SRAI
                end
                else if(funct3==3'b110) op=4'd8;         //OR
                else if(funct3==3'b111) op=4'd9;         //AND
           end
            
           else if(ALUOp==4'b0011) op=4'd0;   //JALR
           
           else if(ALUOp==4'b0100) op=4'd0; //SW  
             
           else if(ALUOp==4'b0101) begin
                if(funct3==3'b000) begin
                    op=4'd1;  //BEQ
                    branchType=3'd0;
                 end
                 else if(funct3==3'b001) begin
                    op=4'd1; //BNE
                    branchType=3'd1;
                 end
                 else if(funct3==3'b100) begin
                    op=4'd3;  //BLT
                    branchType=3'd2;
                 end
                 else if(funct3==3'b101) begin
                    op=4'd3; //BGE
                    branchType=3'd3;
                 end
                 else if(funct3==3'b100) begin
                    op=4'd4;  //BLTU
                    branchType=3'd4;
                 end
                 else if(funct3==3'b101) begin
                    op=4'd4; //BGEU
                    branchType=3'd5;
                 end
           end
           else if(ALUOp==4'b0110 || ALUOp==4'd8) begin // LUI and AUIPC
                val1 = 32'b0;
                op = 4'd0;
            end 
       end
//         always @(*) begin
//             $display("val1=%b , val2=%b", val1,val2);
//         end
endmodule
