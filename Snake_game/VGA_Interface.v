`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2025 11:29:01
// Design Name: 
// Module Name: VGA_Interaface
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


module VGA_Interface(
    input        CLK,
    input      [11:0] COLOUR_IN,
    output reg [9:0]  ADDRH,
    output reg [8:0]  ADDRV,
    output reg [11:0] COLOUR_OUT,
    output reg        HS,
    output reg        VS
);

    // ---------------------------------------------------
    // Timing constants for 640x480 @ 60 Hz VGA
    // ---------------------------------------------------

    // --- Vertical timing (in lines) ---
    parameter VertTimeToPulseWidthEnd   = 10'd2;
    parameter VertTimeToBackPorchEnd    = 10'd31;
    parameter VertTimeToDisplayTimeEnd  = 10'd511;
    parameter VertTimeToFrontPorchEnd   = 10'd521;

    // --- Horizontal timing (in pixels) ---
    parameter HorzTimeToPulseWidthEnd   = 10'd96;
    parameter HorzTimeToBackPorchEnd    = 10'd144;
    parameter HorzTimeToDisplayTimeEnd  = 10'd784;
    parameter HorzTimeToFrontPorchEnd   = 10'd800;
    
    wire CLK_25;
    
    // horizontal counter
    wire horz_trig;
    wire [9:0] horz_count;
    
    // vertical counter
    wire vert_trig;
    wire [9:0] vert_count;
    
    // 25 MHz Clock
    Generic_counter #(
                .COUNTER_WIDTH(2),
                .COUNTER_MAX(3)
            ) baseCounter (
                .CLK(CLK),
                .RESET(1'b0),
                .ENABLE(1'b1),
                .TRIG_OUT(CLK_25),
                .COUNT()
            );
    
    
    
    Generic_counter #(
                .COUNTER_WIDTH(10),
                .COUNTER_MAX(520)
            ) vertCount (
                .CLK(CLK),
                .RESET(1'b0),
                .ENABLE(horz_trig),
                .TRIG_OUT(vert_trig),
                .COUNT(vert_count)
            );
            

    
    Generic_counter #(
                .COUNTER_WIDTH(10),
                .COUNTER_MAX(799)
            ) horzCount (
                .CLK(CLK),
                .RESET(1'b0),
                .ENABLE(CLK_25),
                .TRIG_OUT(horz_trig),
                .COUNT(horz_count)
            );
    
    // Syncs (active low)        
    always@(posedge CLK_25) begin
        HS <= (horz_count < HorzTimeToPulseWidthEnd) ? 0 : 1;
        VS <= (vert_count < VertTimeToPulseWidthEnd) ? 0 : 1;
    end 
    
    // Visible X/Y addresses (0..639 / 0..479), else 0
    always @(posedge CLK_25) begin
        if ((horz_count >= HorzTimeToBackPorchEnd) && (horz_count < HorzTimeToDisplayTimeEnd))
            ADDRH <= horz_count - HorzTimeToBackPorchEnd;
        else
            ADDRH <= 0;
    
        if ((vert_count >= VertTimeToBackPorchEnd) && (vert_count < VertTimeToDisplayTimeEnd))
            ADDRV <= vert_count - VertTimeToBackPorchEnd;
        else
            ADDRV <= 0;
    end
    
    // Gate colour: show only during visible area, blank elsewhere
    always @(posedge CLK_25) begin
        if ((horz_count >= HorzTimeToBackPorchEnd) && (horz_count < HorzTimeToDisplayTimeEnd) &&
            (vert_count >= VertTimeToBackPorchEnd) && (vert_count < VertTimeToDisplayTimeEnd))
            COLOUR_OUT <= {COLOUR_IN[7:4], COLOUR_IN[3:0], COLOUR_IN[11:8]};   // visible area
        else
            COLOUR_OUT <= 12'h000;     // blank area
    end
    
endmodule