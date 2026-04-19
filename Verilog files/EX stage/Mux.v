`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2026 12:52:22 PM
// Design Name: 
// Module Name: Mux
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


module Mux(
        input [31:0] write_data,rs1_val_EX,rs2_val_EX, alu_res_MEM,
        input [1:0] ForwardA, ForwardB,
        output reg [31:0] mux1_data, mux2_data
    );
        //Mux1
        always@(*) begin
            mux1_data=rs1_val_EX;
            if(ForwardA==2'b01) mux1_data=write_data;
            else if(ForwardA==2'b10) mux1_data=alu_res_MEM;
    //        $display("alu_res_MEM=%d",alu_res_MEM);
        end
        //Mux2
        always@(*) begin
            mux2_data=rs2_val_EX;
            if(ForwardB==2'b01) mux2_data=write_data;
            else if(ForwardB==2'b10) mux2_data=alu_res_MEM;
        end
endmodule
