`timescale 1ns / 1ps

module Timer (
    input CLK,
    input RESET,
    input ENABLE,
    output [3:0] SEG_SELECT,
    output [6:0] DEC_OUT
);

    wire trig_1khz;
    wire trig_100hz;
    wire [1:0] strobe_sel;

    wire [3:0] count0, count1, count2, count3;
    wire [4:0] digit0_5b, digit1_5b, digit2_5b, digit3_5b;
    wire [4:0] mux_out;
    wire trig0, trig1, trig2, trig3;

    // 17-bit counter: 100MHz -> 1kHz
    Generic_counter #(
        .COUNTER_WIDTH(17),
        .COUNTER_MAX(99999)
    ) counter_1khz (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(1'b1),
        .TRIG_OUT(trig_1khz)
    );

    // 4-bit counter: 1kHz -> 100Hz
    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) counter_100hz (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig_1khz),
        .TRIG_OUT(trig_100hz)
    );

    // 2-bit strobe counter
    Generic_counter #(
        .COUNTER_WIDTH(2),
        .COUNTER_MAX(3)
    ) strobe_counter (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig_1khz),
        .COUNT(strobe_sel)
    );

    // Decimal counters
    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) counter0 (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig_100hz & ENABLE),
        .COUNT(count0),
        .TRIG_OUT(trig0)
    );

    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) counter1 (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig0 & ENABLE),
        .COUNT(count1),
        .TRIG_OUT(trig1)
    );

    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) counter2 (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig1 & ENABLE),
        .COUNT(count2),
        .TRIG_OUT(trig2)
    );

    Generic_counter #(
        .COUNTER_WIDTH(4),
        .COUNTER_MAX(9)
    ) counter3 (
        .CLK(CLK),
        .RESET(RESET),
        .ENABLE(trig2 & ENABLE),
        .COUNT(count3),
        .TRIG_OUT(trig3)
    );

    // Add DOT bits
    assign digit0_5b = {1'b1, count0};
    assign digit1_5b = {1'b1, count1};
    assign digit2_5b = {1'b0, count2};
    assign digit3_5b = {1'b1, count3};

    // Multiplexer
    Multiplexer_4way mux4 (
        .CONTROL(strobe_sel),
        .IN0(digit0_5b),
        .IN1(digit1_5b),
        .IN2(digit2_5b),
        .IN3(digit3_5b),
        .OUT(mux_out)
    );

    // 7-Segment Decoder
    Decoding_the_world seg7 (
        .SEG_SELECT_IN(strobe_sel),
        .BIN_IN(mux_out),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(DEC_OUT)
    );

endmodule

