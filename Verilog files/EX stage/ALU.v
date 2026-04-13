`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2026 12:41:29 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
        input [3:0] op,
        input [31:0] val1,val2,
        input [2:0] branchType,
        output reg [31:0] result,
        output reg flag
    );
//     always @(*) begin
//             $display("result=%d",result);
//         end
        always@(*) begin
            flag=1'b0;
            case(op)
                4'd0: result=val1+val2; //ADD
                4'd1: begin
                    result=val1-val2; //SUB
                    if(branchType==3'd0) flag=(result==32'b0);//BEQ
                    if(branchType==3'd1) flag=!(result==32'b0); //BNE
                end
                4'd2: result=val1<<val2[4:0];        //SLL,SLLI
                4'd3: begin 
                    result=($signed(val1)<$signed(val2)) ? 32'b1: 32'b0; //SLT
                    if(branchType==3'd2) flag=($signed(val1)<$signed(val2));              //BLT
                    if(branchType==3'd3) flag=!($signed(val1)<$signed(val2));                                  //BGE
                end
                4'd4:begin
                    result=(val1<val2) ? 32'b1: 32'b0; //SLTU
                    if(branchType==3'd4) flag=(val1<val2); //BLTU
                    if(branchType==3'd5) flag=!(val1<val2); //BGEU
                 end                   
                4'd5: result=val1^val2; //XOR
                4'd6: result=(val1>>val2[4:0]); //SRL
                4'd7: result=($signed(val1)>>>val2[4:0]); //SRA
                4'd8: result=(val1 | val2);//OR
                4'd9: result=(val1 & val2);//AND
                default: result=32'b0;
            endcase;
        end
        
endmodule
