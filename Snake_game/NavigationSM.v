module NavigationSM (
    input CLK,
    input BTNU,
    input BTNR,
    input BTND,
    input BTNL,
    output [1:0] DIR
)

reg [1:0] next_direction;
reg [1:0] current_direction;
assign DIR = current_direction;

// Sequential Logic: Direction Register
always @(posedge CLK) begin
    current_direction <= next_direction;
end

// Combinational Logic
always @(*) begin
    case (current_direction)
        2'b00: begin // Up
            if (BTNR)
                next_direction = 2'b01; // Right
            else if (BTNL)
                next_direction = 2'b11; // Left
            else
                next_direction = 2'b00; // Stay Up
        end
        2'b01: begin // Right
            if (BTND)
                next_direction = 2'b10; // Down
            else if (BTNL)
                next_direction = 2'b00; // Up
            else
                next_direction = 2'b01; // Stay Right
        end
        2'b10: begin // Down
            if (BTNL)
                next_direction = 2'b11; // Left
            else if (BTNU)
                next_direction = 2'b01; // Right
            else
                next_direction = 2'b10; // Stay Down
        end
        2'b11: begin // Left
            if (BTNU)
                next_direction = 2'b00; // Up
            else if (BTNR)
                next_direction = 2'b10; // Down
            else
                next_direction = 2'b11; // Stay Left
        end
        default: next_direction = 2'b00; // Default to Up
    endcase
end

endmodule
