module Top_wrapper (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    output [3:0] SEG_SELECT,
    output [7:0] HEX_OUT,
    output [7:0] LED_OUT,
    output [11:0] VGA_OUT,
    output HS,
    output VS
);

    reg [1:0] curr_state;
    reg [1:0] next_state;

    wire [3:0] maze_state_out;
    wire [3:0] led_state_out;

       Maze_wrapper maze (
        .CLK(CLK),
        .RESET(RESET),
        .BTNL(BTNL),
        .BTNC(BTNC),
        .BTNR(BTNR),
        .MASTER_STATE(curr_state),
        .SEG_SELECT(SEG_SELECT),
        .HEX_OUT(HEX_OUT),
        .MazeSM_OUT(maze_state_out)
    );

    LED_displaySM led_display (
        .CLK(CLK),
        .RESET(RESET),
        .MASTER_STATE(curr_state),
        .LED_OUT(LED_OUT),
        .LED_displaySM_OUT(led_state_out)
    );

    VGA_displaySM vga_display (
        .CLK(CLK),
        .RESET(RESET),
        .MASTER_STATE(curr_state),
        .COLOUR_OUT(VGA_OUT),
        .HS(HS),
        .VS(VS)
    );

    always @(posedge CLK) begin
        if (RESET) begin
            curr_state <= 2'b00; // Initial State
        end
        else begin
            curr_state <= next_state;
        end
    end

    always @(*) begin
        case (curr_state)
            2'b00: begin // Idle State
                if (BTNC)
                    next_state = 2'b10; // To VGA State
                else if (BTNL)
                    next_state = 2'b11; // To LED State
                else if (BTNR)
                    next_state = 2'b01; // To Maze State
                else
                    next_state = 2'b00;
            end

            2'b01: begin // Maze State
                if (maze_state_out == 4'hF) // If Maze is complete
                    next_state = 2'b10; // To VGA win State
                else
                    next_state = 2'b01;
            end

            2'b11: begin // LED Display State
                if (led_state_out == 4'hF) // If LEDs are fully lit
                    next_state = 2'b10; // To VGA win State
                else
                    next_state = 2'b11;
            end

            2'b10: begin // VGA Win State
                next_state = 2'b10; // Stay in VGA Win State
            end

            default: begin
                next_state = 2'b00;
            end
        endcase
    end
endmodule