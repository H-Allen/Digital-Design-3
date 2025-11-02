`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2025 12:50:55
// Design Name: 
// Module Name: counter_TB
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


module counter_TB(
    );
    
    reg CLK;
    reg CONTROL_SWITCH;
    
    wire [15:0] OUT;
    
    counter uut (
        .CLK(CLK),
        .CONTROL_SWITCH(CONTROL_SWITCH),
        .OUT(OUT)
    );
    
    initial begin
        CLK = 0;
        forever #50 CLK = ~CLK;
    end
    
    initial begin
        CONTROL_SWITCH = 1;
        #500 CONTROL_SWITCH = 0;
    end    
endmodule
