`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2025 12:37:25
// Design Name: 
// Module Name: Hello_synchronous_world
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


module Hello_synchronous_world(
    input CLK,
    input IN,
    output reg OUT
    );
    
    always@(posedge CLK) OUT <=IN;
 
    
endmodule
