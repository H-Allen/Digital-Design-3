`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 12:34:39
// Design Name: 
// Module Name: VGA_displaySM
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


module VGA_displaySM (
    input CLK,
    input RESET,
    input [1:0] MASTER_STATE,
    input [11:0] COLOUR_IN,
    output [11:0] COLOUR_OUT,
    output [9:0] ADDRH,
    output [8:0] ADDRV,
    output HS,
    output VS
);

    parameter IDLE = 2'b00;
    parameter PLAY = 2'b01;
    parameter WIN = 2'b10;
    parameter LOSE = 2'b11;

    wire [11:0] colour_in;
    wire [11:0] colour_out;
    wire [9:0]  addrh;
    wire [8:0]  addrv;
    
    wire [7:0] img_x = addrh[9:2];
    wire [6:0] img_y = addrv[8:2];
    wire [14:0] img_addr = img_y * 160 + img_x;

    reg [11:0] colour_next;
    reg [15:0] frame_counter;

    VGA_Interface vga_inst (
            .CLK(CLK),
            .COLOUR_IN(colour_in),
            .COLOUR_OUT(colour_out),
            .ADDRH(addrh),
            .ADDRV(addrv),
            .HS(HS),
            .VS(VS)
    );
    
    (* rom_style = "distributed" *)
    reg [11:0] idle_image [0:19199];
    reg [11:0] lose_image [0:19199];
    
    initial begin
        $readmemh("background.mem", idle_image);
        $readmemh("gameover.mem", lose_image);
    end
    
    always @(posedge CLK) begin
        if (RESET) begin
            frame_counter <= 0;
        end
        else if (addrv == 479) begin
            frame_counter <= frame_counter + 1;
        end
    end

    always @(*) begin

        case (MASTER_STATE)
            IDLE: begin 
                colour_next = idle_image[img_addr]; 
            end
            PLAY: begin
                colour_next = COLOUR_IN;
            end
            WIN: begin
                if (addrv[8:0] > 240) begin
                    if(addrh[9:0] > 320)
                        colour_next <= frame_counter[15:8] + addrv[8:0] + addrh[9:0] - 240 - 320;
                    else
                        colour_next <= frame_counter[15:8] + addrv[8:0] - addrh[9:0] - 240 + 320;
                end
                else begin
                    if(addrh[9:0] > 320)
                        colour_next <= frame_counter[15:8] - addrv[8:0] + addrh[9:0] + 240 - 320;
                    else
                        colour_next <= frame_counter[15:8] - addrv[8:0] - addrh[9:0] + 240 + 320;
                end
            end
            LOSE:
                colour_next = lose_image[img_addr];
        endcase
    end

    assign colour_in = colour_next;
    assign COLOUR_OUT = colour_out;
    assign ADDRH = addrh;
    assign ADDRV = addrv;

endmodule