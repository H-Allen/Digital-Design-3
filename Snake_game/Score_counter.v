module Score_counter (
    input CLK,
    input RESET,
    input REACHED_TARGET,
    output [3:0] SEG_SELECT,
    output [7:0] DEC_OUT,
    output GAME_WON
);

    wire
