`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2025 12:03:23
// Design Name: 
// Module Name: VGA_Wrapper
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


module VGA_Wrapper(
    input wire CLK,               // 100 MHz Basys3 clock     // 12 slide switches = base colour
    input wire [11:0] COLOUR_IN,
    output wire [11:0] COLOUR_OUT,
    output wire HS,               // Horizontal Sync
    output wire VS                // Vertical Sync
);

    wire [11:0] colour_in;
    wire [11:0] colour_out;
    wire [9:0]  addrh;  // X coordinate
    wire [8:0]  addrv;  // Y coordinate
    
    VGA_Interface vga_inst (
            .CLK(CLK),
            .COLOUR_IN(colour_in),
            .COLOUR_OUT(colour_out),
            .ADDRH(addrh),
            .ADDRV(addrv),
            .HS(HS),
            .VS(VS)
    );
    
    reg [11:0] colour_next;
    
    always @(*) begin
        colour_next = COLOUR_IN;
        if ( (addrh < 10 && addrv < 10) ||                    // top-left
             (addrh > 630 && addrv < 10) ||                   // top-right
             (addrh < 10 && addrv > 470) ||                   // bottom-left
             (addrh > 630 && addrv > 470) ) begin             // bottom-right
            colour_next = ~COLOUR_IN;
        end
    end

    assign colour_in = colour_next;
    
    assign COLOUR_OUT = colour_out;

    
endmodule
