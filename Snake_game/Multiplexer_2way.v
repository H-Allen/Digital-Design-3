`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 15:06:52
// Design Name: 
// Module Name: Multiplexer_2way
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


module Multiplexer_2way(
        input CONTROL,
        input [3:0] IN0,
        input [3:0] IN1,
        output reg [3:0] OUT
    );
    
    always@(*)
        begin
            case (CONTROL)
                1'b0 : OUT <= IN0;
                1'b1 : OUT <= IN1;
                default : OUT <= 5'b0000;
        endcase
    end
endmodule
