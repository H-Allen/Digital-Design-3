module Score_counter (
    input CLK,
    input RESET,
    input ENABLE,
    output [3:0] SEG_SELECT,
    output [6:0] DEC_OUT
);
