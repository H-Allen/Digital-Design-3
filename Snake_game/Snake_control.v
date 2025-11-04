`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 15:25:51
// Design Name: 
// Module Name: Snake_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Snake_control(
        input CLK,
        input RESET,
        input [1:0] NAV_STATE,
        input [1:0] MASTER_STATE,
        input [7:0] FOOD_TARGET_H,
        input [6:0] FOOD_TARGET_V,
        input [9:0] ADDRH,
        input [8:0] ADDRV,
        output [11:0] COLOUR_OUT,
        output TARGET_REACHED
    );

    parameter snake_length = 20;
    parameter max_x = 159;
    parameter max_y = 119;
    
    parameter IDLE = 2'b00;
    parameter PLAY = 2'b01;
    parameter WIN = 2'b10;
    
    parameter UP = 2'b00;
    parameter DOWN = 2'b10;
    parameter LEFT = 2'b11;
    parameter RIGHT = 2'b01;
    
    //Snake movement
    parameter MOVE_SPEED = 20'd3000000;
    wire move_enable;
    
    Generic_counter #(
        .COUNTER_WIDTH(25),
        .COUNTER_MAX(MOVE_SPEED)
    ) move_counter (
        .CLK(CLK),
        .RESET(RESET || MASTER_STATE != PLAY),
        .ENABLE(1'b1),
        .TRIG_OUT(move_enable),
        .COUNT()
    );
    
    //Snake position
    reg [7:0] SnakeState_X [0: snake_length - 1];
    reg [6:0] SnakeState_Y [0: snake_length - 1];
    
    genvar PinNo;
    generate
        for (PinNo = 0; PinNo < snake_length - 1; PinNo = PinNo + 1)
        begin: PinShift
            always@(posedge CLK) begin
                if(RESET) begin
                    SnakeState_X[PinNo+1] <= 80;
                    SnakeState_Y[PinNo+1] <= 100;
                end
                else if (move_enable) begin
                    SnakeState_X[PinNo+1] <= SnakeState_X[PinNo];
                    SnakeState_Y[PinNo+1] <= SnakeState_Y[PinNo];
                end
            end
        end
    endgenerate
    
    //Snake Position Update
    integer i;
    always @(posedge CLK) begin
        if (RESET) begin
            SnakeState_X[0] <= 80;
            SnakeState_Y[0] <= 100;
          
        end
        else if (move_enable) begin
            // Calculate new head position based on direction
            case (NAV_STATE)
                UP: begin
                    if(SnakeState_Y[0] == 0)
                        SnakeState_Y[0] <= max_y;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0]-1;
                end
                
                DOWN: begin
                    if (SnakeState_Y[0] == max_y)
                        SnakeState_Y[0] <= 0;
                    else
                        SnakeState_Y[0] <= SnakeState_Y[0] + 1;
                end

                LEFT: begin
                    if (SnakeState_X[0] == 0)
                        SnakeState_X[0] <= max_x;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] - 1;
                end

                RIGHT: begin
                    if (SnakeState_X[0] == max_x)
                        SnakeState_X[0] <= 0;
                    else
                        SnakeState_X[0] <= SnakeState_X[0] + 1;
                end
            endcase
        end
    end

    reg target_reached;
    always @(posedge CLK) begin
        if (RESET)
            target_reached <= 1'b0;
        else if (SnakeState_X[0] == FOOD_TARGET_H && SnakeState_Y[0] == FOOD_TARGET_V)
            target_reached <= 1'b1;
        else
            target_reached <= 1'b0;
    end
    assign TARGET_REACHED = target_reached;
    
    reg [11:0] colour_out;
    integer j;
    always @(*) begin
        colour_out = 12'h0FF; // Default background (black)
        if ((ADDRH[9:2] == FOOD_TARGET_H) && (ADDRV[8:2] == FOOD_TARGET_V)) begin
                    colour_out = 12'hF00; // Red for food
            end
        for (j = 0; j < snake_length; j = j + 1) begin
            if ((ADDRH[9:2] == SnakeState_X[j]) && (ADDRV[8:2] == SnakeState_Y[j])) begin
                colour_out = 12'hFFF; // Head = green
            end
        end
    end
    assign COLOUR_OUT = colour_out;
  
endmodule  