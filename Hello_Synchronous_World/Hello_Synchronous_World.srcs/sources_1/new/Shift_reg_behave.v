`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2025 15:26:20
// Design Name: 
// Module Name: Shift_reg_behave
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


module Shift_reg_behave(
    input CLK,
    input IN,
    output [15:0] OUT
    );
    
    reg [15:0] DTypes;
    
    always@(posedge CLK) begin
        DTypes = {DTypes[14:0], IN};
    end
    
    assign OUT = DTypes;

endmodule
