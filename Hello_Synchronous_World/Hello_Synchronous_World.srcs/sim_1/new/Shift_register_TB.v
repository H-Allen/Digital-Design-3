`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2025 14:47:50
// Design Name: 
// Module Name: Shift_register_TB
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


module Shift_register_TB(
    );
    reg CLK;
    reg IN;
   
    wire [15:0] OUT;
        
    Shift_register uut(
        .CLK(CLK),
        .IN(IN),
        .OUT(OUT)
    );
    
    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end 
    
    initial begin
        IN = 0;
        #10
        #5 IN = 1;
        #5 IN = 0;
        #20 IN = 1;
        #20 IN = 1;
    end
endmodule
