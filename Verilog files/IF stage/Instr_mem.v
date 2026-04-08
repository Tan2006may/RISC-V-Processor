`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2026 09:07:43 PM
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(
    input [31:0] pc,
    output wire [31:0] instr
    );
    reg [31:0] imem[0:255];
    initial begin
        $readmemb("instructions_mem.mem", imem);
        if (imem[11] === 32'bx)
            $display("STOPPED LOADING AT LINE 8");
    end
    assign instr=imem[pc>>2];   
endmodule
