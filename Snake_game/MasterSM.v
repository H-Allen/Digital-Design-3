`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 14:16:10
// Design Name: 
// Module Name: MasterSM
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


module MasterSM(
    input CLK,
    input RESET,
    input BTNU,
    input BTND,
    input BTNR,
    input BTNL,
    input GAME_WON,
    output [1:0] MASTER_STATE
);
    
    parameter IDLE = 2'b00;
    parameter PLAY = 2'b01;
    parameter WIN = 2'b10;
    
    reg[1:0] curr_state;
    reg[1:0] next_state;
    
    always @(posedge CLK) begin
        if (RESET) begin
            curr_state <= IDLE; // Initial State
        end
        else begin
            curr_state <= next_state;
        end
    end
    
    always @(*) begin
        case (curr_state)
            IDLE: begin
                if(BTNU || BTND || BTNL || BTNR)
                    next_state = PLAY;
            end
            
            PLAY: begin
                if(GAME_WON)
                    next_state = WIN;
            end
        endcase
    end
    
    assign MASTER_STATE = curr_state;
    
endmodule
