module Basic_state_machine (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    output [2:0] STATE_OUT
);

reg [2:0] Current_State, Next_State;
assign STATE_OUT = Current_State;

//Sequential Logic: State Register
always @(posedge CLK) begin
    if (RESET)
        Current_State <= 3'b000; // Initial State
    else
        Current_State <= Next_State;
end

//Combinational Logic
always @(*) begin
    case (Current_State)
        3'b000: begin // State 0
            if (BTNC)
                Next_State = 3'b110; // Move to State 6
            else
                Next_State = 3'b000; // Stay in State 0
        end
        3'b110: begin // State 6
            if (BTNL)
                Next_State = 3'b000; // Move to State 0
            else if (BTNR)
                Next_State = 3'b010; // Move to State 2
            else
                Next_State = 3'b110; // Stay in State 6
        end
        3'b010: begin // State 2
            if (BTNC)
                Next_State = 3'b001; // Move to State 1
            else if (BTNL)
                Next_State = 3'b000; // Move to State 0
            else
                Next_State = 3'b010; // Stay in State 2
        end
        3'b001: begin // State 1
            if (BTNR)
                Next_State = 3'b010; // Move to State 2
            else if (BTNL)
                Next_State = 3'b101; // Move to State 5
            else
                Next_State = 3'b001; // Stay in State 1
        end
        3'b101: begin // State 5
            if (BTNC)
                Next_State = 3'b011; // Move to State 3
            else if (BTNR)
                Next_State = 3'b000; // Move to State 0
            else
                Next_State = 3'b101; // Stay in State 5
        end
        3'b011: begin // State 3
            if (BTNL)
                Next_State = 3'b100; // Move to State 4
            else if (BTNR)
                Next_State = 3'b010; // Move to State 2
            else
                Next_State = 3'b011; // Stay in State 3
        end
        3'b100: begin // State 4
            if (BTNC)
                Next_State = 3'b110; // Move to State 6
            else if (BTNR)
                Next_State = 3'b111; // Move to State 7
            else
                Next_State = 3'b100; // Stay in State 4
        end
        3'b111: begin // State 7
            Next_State = 3'b111; // Stay in State 7
        end
    endcase
end