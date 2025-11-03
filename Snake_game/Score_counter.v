`timescale 1ns / 1ps

module Score_Counter (
    input CLK,
    input RESET,
    input REACHED_TARGET,        // Increment when snake eats target
    output [3:0] SEG_SELECT,     // Which 7-seg display to light
    output [6:0] DEC_OUT,        // Segments to display
    output GAME_WON              // Goes high when score reaches 10
);

    // Strobe counter for multiplexing the displays
    wire [1:0] strobe_sel;
    wire trig_strobe;
    
    // Score digit counters
    wire [3:0] ones_digit;       // 0-9
    wire [3:0] tens_digit;       // 0-1 (we only count to 10)
    wire ones_overflow;          // Triggers when ones goes 9->0
    
    // Multiplexer signals
    wire [4:0] digit0_5b, digit1_5b, digit2_5b, digit3_5b;
    wire [4:0] mux_out;

    // ---------------------------------------------
    // Strobe Counter for Display Multiplexing
    // Cycles through displays fast enough that they appear solid
    // ---------------------------------------------
    
    // Generate ~1kHz strobe for display refresh
    Generic_counter #(
        .COUNTER_WIDTH(17),
        .COUNTER_MAX(99999)          // 100MHz / 100000 = 1kHz
    ) strobe_gen (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(1'b1),
        .TRIG_OUT(trig_strobe)
    );
    
    // 2-bit counter to select which display (0-3)
    Generic_counter #(
        .COUNTER_WIDTH(2),
        .COUNTER_MAX(3)
    ) strobe_counter (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig_strobe),
        .COUNT(strobe_sel)
    );

    // ---------------------------------------------
    // Score Counters
    // ---------------------------------------------
    
    // Ones digit: counts 0-9, increments on REACHED_TARGET
    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) ones_counter (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(REACHED_TARGET),
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

    // ---------------------------------------------
    // Game Won Detection
    // Score of 10 = tens_digit=1, ones_digit=0
    // ---------------------------------------------
    assign GAME_WON = (tens_digit == 4'd1) && (ones_digit == 4'd0);

    // ---------------------------------------------
    // Prepare digits for multiplexer
    // Format: {dot, digit[3:0]}
    // We'll display the score on the rightmost two displays
    // ---------------------------------------------
    
    // Display 0 (rightmost) - ones digit
    assign digit0_5b = {1'b0, ones_digit};   // No dot
    
    // Display 1 - tens digit  
    assign digit1_5b = {1'b0, tens_digit};   // No dot
    
    // Displays 2 and 3 - blank
    assign digit2_5b = {1'b0, 4'hF};         // F = blank in decoder
    assign digit3_5b = {1'b0, 4'hF};         // F = blank in decoder

    // ---------------------------------------------
    // Multiplexer - selects which digit to display
    // ---------------------------------------------
    Multiplexer_4way mux4 (
        .CONTROL(strobe_sel),
        .IN0(digit0_5b),
        .IN1(digit1_5b),
        .IN2(digit2_5b),
        .IN3(digit3_5b),
        .OUT(mux_out)
    );

    // ---------------------------------------------
    // 7-Segment Decoder
    // ---------------------------------------------
    Decoding_the_world seg7 (
        .SEG_SELECT_IN(strobe_sel),
        .BIN_IN(mux_out),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(DEC_OUT)
    );

endmodule