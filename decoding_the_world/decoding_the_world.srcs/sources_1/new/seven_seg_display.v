`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 11:45:54
// Design Name: 
// Module Name: seven_seg_display
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


module seven_seg_display(
    input wire [3:0] SW,
    output wire [7:0] SEG,
    output wire [3:0] AN
    );
    
    Decoding_the_world decoder (
        .SEG_SELECT_IN(2'b00),
        .BIN_IN(SW),
        .DOT_IN(1'b1),
        .SEG_SELECT_OUT(AN),
        .HEX_OUT(SEG)
    );
endmodule
