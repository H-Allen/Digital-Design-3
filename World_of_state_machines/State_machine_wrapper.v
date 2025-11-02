module State_machine_wrapper (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    output [3:0] SEG_SELECT_OUT,
    output [7:0] DEC_OUT
);

wire [2:0] STATE_OUT;

Basic_state_machine state_machine (
    .CLK(CLK),
    .RESET(RESET),
    .BTNL(BTNL),
    .BTNC(BTNC),
    .BTNR(BTNR),
    .STATE_OUT(STATE_OUT)
);

Decoding_the_world decoder (
    .SEG_SELECT_IN(2'b00),
    .BIN_IN({1'b0, STATE_OUT}),
    .DOT_IN(1'b1),
    .SEG_SELECT_OUT(SEG_SELECT_OUT),
    .HEX_OUT(DEC_OUT)
);