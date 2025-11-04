`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 14:29:36
// Design Name: 
// Module Name: Score_counter
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


module Score_counter(
        input CLK,
        input RESET,
        input TARGET_REACHED,
        output [3:0] SEG_SELECT,
        output [6:0] DEC_OUT,
        output GAME_WON
    );
    
    // Strobe counter for multiplexing the displays
    wire [1:0] strobe_sel;
    wire trig_strobe;
    
    wire [3:0] ones_digit;
    wire [3:0] tens_digit;
    wire ones_overflow;          // Triggers when ones goes 9->0
    wire [3:0] mux_out;
    
    Generic_counter #(
        .COUNTER_WIDTH(17),
        .COUNTER_MAX(99999)
    ) strobe_gen (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(1'b1),
        .TRIG_OUT(trig_strobe)
    );
    
    Generic_counter #(
        .COUNTER_WIDTH(2),
        .COUNTER_MAX(1)
    ) strobe_counter (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig_strobe),
        .COUNT(strobe_sel)
    );

    
    // Ones digit: counts 0-9, increments on REACHED_TARGET
    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) ones_counter (
        .CLK(TARGET_REACHED),
        .RESET(RESET),
        .ENABLE(1'b1),
        .COUNT(ones_digit),
        .TRIG_OUT(ones_overflow)     // Pulses when going from 9 to 0
    );
    
    // Tens digit: counts 0-1, increments when ones overflows
    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(1)              // Only needs to count to 1
    ) tens_counter (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(ones_overflow),      // Increments when ones goes 9->0
        .COUNT(tens_digit)
    );

    reg game_won;
    always @(*) begin
        if (RESET) 
            game_won <= 0;
        else
            game_won <= (tens_digit == 4'd1) && (ones_digit == 4'd0);
    end
    assign GAME_WON = game_won;

    Multiplexer_2way mux2 (
        .CONTROL(strobe_sel),
        .IN0(ones_digit),
        .IN1(tens_digit),
        .OUT(mux_out)
    );

    Seg7_decoder seg7 (
        .SEG_SELECT_IN(strobe_sel),
        .BIN_IN(mux_out),
        .DOT_IN(1'b0),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(DEC_OUT)
    );
    
endmodule
