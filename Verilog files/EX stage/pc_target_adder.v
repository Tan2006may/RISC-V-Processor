`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:09:23 PM
// Design Name: 
// Module Name: pc_target_adder
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


module pc_target_adder(
        input [31:0] pc_EX,imm_EX,
        output wire [31:0] pc_target
    );
        assign pc_target=pc_EX+imm_EX;
//        always@(*)begin
//            $display("imm_EX=%d",imm_EX);
//        end
endmodule
