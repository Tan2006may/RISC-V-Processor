`timescale 1ns / 1ps

module tb;

    reg clk;
    reg rst;

    // Instantiate DUT
    Top uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;

        // Reset pulse
        #10;
        rst = 0;

        // Run simulation
        #500;

        $finish;
    end

    // Monitor important signals
   always @(posedge clk) begin
    $display("PC=%d | instr=%h | rd=%d | val1=%d, val2=%d, op=%d, res_ex=%d | res_mem=%d",
        uut.pc_IF,
        uut.instr,
        uut.rd_WB,
        uut.ALU.val1,
        uut.ALU.val2,
        uut.ALU.op,
        uut.ALU.result,
        uut.MEM.alu_res
    );
end
endmodule
