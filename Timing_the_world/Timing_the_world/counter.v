`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2025 12:50:18
// Design Name: 
// Module Name: counter
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

module counter(
    input CLK,
    input CONTROL_SWITCH,
    output [15:0] OUT
    );
    
    reg [15:0] Value = 0;
    
    always@(posedge CLK) begin
        if (CONTROL_SWITCH)
            Value <= Value + 1;
        else 
            Value <= Value - 1;
     end
     
     assign OUT = Value;
endmodule
