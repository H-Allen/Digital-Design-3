module LED_displaySM (
    input CLK,
    input RESET,
    input [1:0] MASTER_STATE,
    output [7:0] LED_OUT,
    output [3:0] LED_displaySM_OUT
);

//Counter code
reg [25:0] curr_count;
reg [25:0] next_count;

//State Machine code
reg [3:0] curr_state;
reg [3:0] next_state;

reg [7:0] Curr_LEDs;
reg [7:0] Next_LEDs;

//Sequential Logic
always @(posedge CLK) begin
    if (RESET) begin
        curr_count <= 0;
        curr_state <= 4'h0;
        Curr_LEDs <= 8'h00;
    end 
    else begin
        curr_count <= next_count;
        curr_state <= next_state;
        Curr_LEDs <= Next_LEDs;
    end
end

//Combinational Logic
always @(curr_state or MASTER_STATE or curr_count) begin
    case (curr_state)
        4'h0: begin
            if (MASTER_STATE == 2'b11)
                next_state = 4'h1;
            else
                next_state = 4'h0;

            next_count <= 0;
            Next_LEDs <= 8'h00;
        end

        4'h1: begin
            if (curr_count == 50000000) begin
                next_state = 4'h2;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00000001;
        end

        4'h2: begin
            if (curr_count == 50000000) begin
                next_state = 4'h3;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00000010;
        end

        4'h3: begin
            if (curr_count == 50000000) begin
                next_state = 4'h4;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00000100;
        end

        4'h4: begin
            if (curr_count == 50000000) begin
                next_state = 4'h5;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00001000;
        end

        4'h5: begin
            if (curr_count == 50000000) begin
                next_state = 4'h6;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00010000;
        end

        4'h6: begin
            if (curr_count == 50000000) begin
                next_state = 4'h7;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b00100000;
        end

        4'h7: begin
            if (curr_count == 50000000) begin
                next_state = 4'h8;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b01000000;
        end

        4'h8: begin
            if (curr_count == 50000000) begin
                next_state = 4'hF;
                next_count <= 0;
            end
            else begin
                next_state = curr_state;
                next_count <= curr_count + 1;
            end
            Next_LEDs <= 8'b10000000;
        end

        4'hF: begin
            next_state = 4'hF;
            next_count <= 0;
            Next_LEDs <= 8'h00;
        end
    endcase
end

assign LED_OUT = Curr_LEDs;
assign LED_displaySM_OUT = curr_state;

endmodule
