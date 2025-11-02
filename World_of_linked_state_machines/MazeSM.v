module MazeSM (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    input [1:0] MASTER_STATE,
    output [3:0] DEC_OUT,
    output [3:0] MazeSM_OUT
);

    // 7-seg display code
    reg [3:0] curr_num;
    reg [3:0] next_num;

    // state machine code
    reg [3:0] curr_state;
    reg [3:0] next_state;

    assign MazeSM_OUT = curr_state;
    assign DEC_OUT = curr_num;

    // Sequential Logic: State Register
    always @(posedge CLK) begin
        if (RESET) begin
            curr_state <= 4'b0000; // Idle State
            curr_num   <= 4'b0000;
        end
        else begin
            curr_state <= next_state;
            curr_num   <= next_num;
        end
    end

    // Combinational Logic
    always @(*) begin
        // default assignments to avoid inferred latches
        next_state = curr_state;
        next_num   = curr_num;

        case (curr_state)
            4'h0: begin // IDLE
                next_num = 4'h0;  // Display 0
                if (MASTER_STATE == 2'b01)
                    next_state = 4'h1;  // Start maze
                else
                    next_state = 4'h0;
            end
            
            4'h1: begin // Maze State 0
                next_num = 4'h0;  // Display 0
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;  // Back to IDLE
                else if (BTNC)
                    next_state = 4'h2;  // To Maze State 6
                else
                    next_state = 4'h1;
            end
            
            4'h2: begin // Maze State 6
                next_num = 4'h6;  // Display 6
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNL)
                    next_state = 4'h1;  // To State 0
                else if (BTNR)
                    next_state = 4'h3;  // To State 2
                else
                    next_state = 4'h2;
            end
            
            4'h3: begin // Maze State 2
                next_num = 4'h2;  // Display 2
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNC)
                    next_state = 4'h4;  // To State 1
                else if (BTNL)
                    next_state = 4'h1;  // To State 0
                else
                    next_state = 4'h3;
            end
            
            4'h4: begin // Maze State 1
                next_num = 4'h1;  // Display 1
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNR)
                    next_state = 4'h3;  // To State 2
                else if (BTNL)
                    next_state = 4'h5;  // To State 5
                else
                    next_state = 4'h4;
            end
            
            4'h5: begin // Maze State 5
                next_num = 4'h5;  // Display 5
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNC)
                    next_state = 4'h6;  // To State 3
                else if (BTNR)
                    next_state = 4'h1;  // To State 0
                else
                    next_state = 4'h5;
            end
            
            4'h6: begin // Maze State 3
                next_num = 4'h3;  // Display 3
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNL)
                    next_state = 4'h7;  // To State 4
                else if (BTNR)
                    next_state = 4'h3;  // To State 2
                else
                    next_state = 4'h6;
            end
            
            4'h7: begin // Maze State 4
                next_num = 4'h4;  // Display 4
                if (MASTER_STATE != 2'b01)
                    next_state = 4'h0;
                else if (BTNC)
                    next_state = 4'h2;  // To State 6
                else if (BTNR)
                    next_state = 4'h8;  // To State 7 (winning!)
                else
                    next_state = 4'h7;
            end
            
            4'h8: begin // Maze State 7 (Goal reached!)
                next_num = 4'h7;  // Display 7
                next_state = 4'hF;  // Immediately go to FINISHED
            end
            
            4'hF: begin // FINISHED
                next_num = 4'h7;
                next_state = 4'hF;  // Stay finished
            end
            
            default: begin
                next_state = 4'h0;
                next_num = 4'h0;
            end
        endcase
    end
endmodule