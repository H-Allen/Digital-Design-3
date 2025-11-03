`timescale 1ns / 1ps

module Snake_Control(
    input wire CLK,
    input wire RESET,
    input wire [1:0] NAV_STATE,        // Direction from Navigation State Machine
    input wire [1:0] MASTER_STATE,     // Game state from Master State Machine
    input wire [7:0] TARGET_X,         // Target position from Target_Generator
    input wire [6:0] TARGET_Y,
    input wire [9:0] ADDRH,            // Current pixel X from VGA (0-639)
    input wire [8:0] ADDRV,            // Current pixel Y from VGA (0-479)
    output reg [11:0] COLOUR_OUT,      // Color for current pixel
    output reg REACHED_TARGET          // Pulse when snake eats target
);

    // ========================================
    // PARAMETERS
    // ========================================
    parameter SnakeLength = 20;         // Length of snake (max ~40 for FPGA)
    parameter MaxX = 159;               // Max X coordinate (160 columns)
    parameter MaxY = 119;               // Max Y coordinate (120 rows)
    
    // State encodings (should match your state machines)
    localparam IDLE = 2'b00;
    localparam PLAY = 2'b01;
    localparam WIN  = 2'b10;
    
    localparam UP    = 2'b00;
    localparam DOWN  = 2'b01;
    localparam LEFT  = 2'b10;
    localparam RIGHT = 2'b11;
    
    // Color definitions
    localparam COLOUR_SNAKE  = 12'hFF0;  // Yellow
    localparam COLOUR_TARGET = 12'hF00;  // Red
    localparam COLOUR_BACK   = 12'h00F;  // Blue

    // ========================================
    // SNAKE POSITION STORAGE
    // 2D array: each element is 15 bits [X:Y]
    // [14:7] = X coordinate (8 bits)
    // [6:0]  = Y coordinate (7 bits)
    // ========================================
    reg [14:0] snake_body [0:SnakeLength-1];
    
    integer i;  // For loops

    // ========================================
    // SNAKE MOVEMENT COUNTER
    // We don't want the snake to move every clock cycle!
    // This counter slows it down
    // ========================================
    reg [19:0] move_counter;
    localparam MOVE_DELAY = 20'd500000;  // Move every 500k clocks (~5ms at 100MHz)
    wire move_enable;
    
    assign move_enable = (move_counter == MOVE_DELAY);
    
    always @(posedge CLK) begin
        if (RESET || MASTER_STATE != PLAY)
            move_counter <= 0;
        else if (move_counter == MOVE_DELAY)
            move_counter <= 0;
        else
            move_counter <= move_counter + 1;
    end

    // ========================================
    // SNAKE POSITION UPDATE
    // Shift register that moves the snake
    // ========================================
    always @(posedge CLK) begin
        if (RESET) begin
            // Initialize snake in the middle of screen, moving right
            for (i = 0; i < SnakeLength; i = i + 1) begin
                snake_body[i] <= {8'd(80-i), 7'd60};  // Horizontal line at (80-i, 60)
            end
        end
        else if (MASTER_STATE == PLAY && move_enable) begin
            // Shift all body segments
            for (i = SnakeLength-1; i > 0; i = i - 1) begin
                snake_body[i] <= snake_body[i-1];
            end
            
            // Calculate new head position based on direction
            case (NAV_STATE)
                UP: begin
                    if (snake_body[0][6:0] == 0)
                        snake_body[0] <= {snake_body[0][14:7], 7'd(MaxY)};  // Wrap to bottom
                    else
                        snake_body[0] <= {snake_body[0][14:7], snake_body[0][6:0] - 7'd1};
                end
                
                DOWN: begin
                    if (snake_body[0][6:0] == MaxY)
                        snake_body[0] <= {snake_body[0][14:7], 7'd0};  // Wrap to top
                    else
                        snake_body[0] <= {snake_body[0][14:7], snake_body[0][6:0] + 7'd1};
                end
                
                LEFT: begin
                    if (snake_body[0][14:7] == 0)
                        snake_body[0] <= {8'd(MaxX), snake_body[0][6:0]};  // Wrap to right
                    else
                        snake_body[0] <= {snake_body[0][14:7] - 8'd1, snake_body[0][6:0]};
                end
                
                RIGHT: begin
                    if (snake_body[0][14:7] == MaxX)
                        snake_body[0] <= {8'd0, snake_body[0][6:0]};  // Wrap to left
                    else
                        snake_body[0] <= {snake_body[0][14:7] + 8'd1, snake_body[0][6:0]};
                end
            endcase
        end
    end

    // ========================================
    // TARGET DETECTION
    // Check if snake head has reached target
    // ========================================
    always @(posedge CLK) begin
        if (RESET)
            REACHED_TARGET <= 0;
        else if (MASTER_STATE == PLAY && move_enable) begin
            // Compare head position with target position
            if (snake_body[0][14:7] == TARGET_X && 
                snake_body[0][6:0] == TARGET_Y)
                REACHED_TARGET <= 1;
            else
                REACHED_TARGET <= 0;
        end
        else
            REACHED_TARGET <= 0;
    end

    // ========================================
    // COLOR DETERMINATION FOR VGA
    // For each pixel address, decide what color it should be
    // ========================================
    
    // Reduce resolution: divide by 4
    // ADDRH is 0-639, we want 0-159
    // ADDRV is 0-479, we want 0-119
    wire [7:0] pixel_x;
    wire [6:0] pixel_y;
    
    assign pixel_x = ADDRH[9:2];  // Divide by 4
    assign pixel_y = ADDRV[8:2];  // Divide by 4
    
    // Check if current pixel is part of snake or target
    reg is_snake;
    reg is_target;
    
    always @(*) begin
        // Default: not snake
        is_snake = 0;
        
        // Check all snake body segments
        for (i = 0; i < SnakeLength; i = i + 1) begin
            if (snake_body[i][14:7] == pixel_x && 
                snake_body[i][6:0] == pixel_y)
                is_snake = 1;
        end
    end
    
    always @(*) begin
        // Check if current pixel is the target
        is_target = (TARGET_X == pixel_x) && (TARGET_Y == pixel_y);
    end
    
    // Assign color based on what the pixel represents
    always @(*) begin
        if (is_snake)
            COLOUR_OUT = COLOUR_SNAKE;      // Yellow for snake
        else if (is_target)
            COLOUR_OUT = COLOUR_TARGET;     // Red for target
        else
            COLOUR_OUT = COLOUR_BACK;       // Blue for background
    end

endmodule