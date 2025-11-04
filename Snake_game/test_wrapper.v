`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 13:24:58
// Design Name: 
// Module Name: test_wrapper
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


module test_wrapper (
    input CLK,
    input RESET,
    input BTNL,
    input BTNR,
    input BTNU,
    input BTND,
    output [3:0] SEG_SELECT,
    output [7:0] HEX_OUT,
    output [7:0] LED_OUT,
    output [11:0] VGA_OUT,
    output HS,
    output VS
);
    
    //Navigation state machine -> direction of snake movement
    wire [1:0] direction;
    
    //Target generator 
    wire food_addr_h;
    wire food_addr_v;
    wire target_reached;
        
    //state of master state machine: IDLE -> PLAY -> WIN
    wire [1:0] master_state;
    
    wire game_won;
    
    wire [11:0] vga_colour;
    
    wire [9:0] addrh;
    wire [8:0] addrv;

    MasterSM master (
        .CLK(CLK),
        .RESET(RESET),
        .BTNU(BTNU),
        .BTNR(BTNR),
        .BTND(BTND),
        .BTNL(BTNL),
        .GAME_WON(game_won),
        .MASTER_STATE(master_state)
    );
    
    Snake_control snake (
        .CLK(CLK),
        .RESET(RESET),
        .NAV_STATE(direction),
        .MASTER_STATE(master_state),
        .FOOD_TARGET_H(food_addr_h),
        .FOOD_TARGET_V(food_addr_v),
        .ADDRH(addrh),
        .ADDRV(addrv),
        .COLOUR_OUT(vga_colour),
        .TARGET_REACHED(target_reached)
    );

    VGA_displaySM vga_display (
        .CLK(CLK),
        .RESET(RESET),
        .MASTER_STATE(master_state),
        .COLOUR_IN(vga_colour),
        .COLOUR_OUT(VGA_OUT),
        .ADDRH(addrh),
        .ADDRV(addrv),
        .HS(HS),
        .VS(VS)
    );
    
    NavigationSM nav (
        .CLK(CLK),
        .BTNU(BTNU),
        .BTNR(BTNR),
        .BTND(BTND),
        .BTNL(BTNL),
        .DIR(direction)
    );
    
    Target_generator food_target (
        .CLK(CLK),
        .RESET(RESET),
        .TARGET_REACHED(target_reached),
        .ADDRH(food_addr_h),
        .ADDRV(food_addr_v)
    );
    
    Score_counter score (
        .CLK(CLK),
        .RESET(RESET),
        .TARGET_REACHED(target_reached),
        .SEG_SELECT(SEG_SELECT),
        .DEC_OUT(HEX_OUT),
        .GAME_WON(game_won)
    );
    
    
    
endmodule
