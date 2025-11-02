module Maze_wrapper (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    input [1:0] MASTER_STATE,
    output [3:0] SEG_SELECT,
    output [7:0] HEX_OUT,
    output [3:0] MazeSM_OUT
);

    wire [3:0] seg7_display_out;

    Decoding_the_world decoder (
        .SEG_SELECT_IN(2'b00),
        .BIN_IN(seg7_display_out),
        .DOT_IN(1'b1),
        .SEG_SELECT_OUT(SEG_SELECT),
        .HEX_OUT(HEX_OUT)
    );

    MazeSM maze (
        .CLK(CLK),
        .RESET(RESET),
        .BTNL(BTNL),
        .BTNC(BTNC),
        .BTNR(BTNR),
        .MASTER_STATE(MASTER_STATE),
        .DEC_OUT(seg7_display_out),
        .MazeSM_OUT(MazeSM_OUT)
    );
endmodule