`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2025 12:09:43
// Design Name: 
// Module Name: Shift_reg2d_TB
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


module Shift_reg2d_TB(
    );
    reg CLK;
    reg [3:0] IN;
    
    wire [3:0] OUT_0, OUT_1, OUT_2, OUT_3;
    wire [3:0] OUT_4, OUT_5, OUT_6, OUT_7;
    wire [3:0] OUT_8, OUT_9, OUT_10, OUT_11;
    wire [3:0] OUT_12, OUT_13, OUT_14, OUT_15;
    
    Shift_reg2D uut (
        .CLK(CLK),
        .IN(IN),
        .OUT_0(OUT_0),
        .OUT_1(OUT_1),
        .OUT_2(OUT_2),
        .OUT_3(OUT_3),
        .OUT_4(OUT_4),
        .OUT_5(OUT_5),
        .OUT_6(OUT_6),
        .OUT_7(OUT_7),
        .OUT_8(OUT_8),
        .OUT_9(OUT_9),
        .OUT_10(OUT_10),
        .OUT_11(OUT_11),
        .OUT_12(OUT_12),
        .OUT_13(OUT_13),
        .OUT_14(OUT_14),
        .OUT_15(OUT_15)
    );
    
    initial begin
        CLK = 0;
        forever #50 CLK = ~CLK;
    end
    
    initial begin
        IN = 0;
        #100;
        #100 IN = 1;
        #100 IN = 2;
        #100 IN = 3;
        #100 IN = 4;
    end
endmodule
