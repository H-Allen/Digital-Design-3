`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2025 14:22:51
// Design Name: 
// Module Name: Target_generator
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


module Target_generator(
    input CLK,
    input RESET,
    input TARGET_REACHED,
    output reg [7:0] ADDRH,
    output reg [6:0] ADDRV
);

    reg [7:0] horz_lfsr;
    wire horz_feedback;

    reg [6:0] vert_lfsr;
    wire vert_feedback;

    assign horz_feedback = ~(horz_lfsr[7] ^ horz_lfsr[5] ^ horz_lfsr[4] ^ horz_lfsr[3]);
    assign vert_feedback = ~(vert_lfsr[6] ^ vert_lfsr[5]);

    always @(posedge CLK) begin
        if (RESET) begin 
            horz_lfsr <= 8'b01010101;
            vert_lfsr <= 7'b0101010;
        end
        else begin
            horz_lfsr <= {horz_feedback, horz_lfsr[7:1]};
            vert_lfsr <= {vert_feedback, vert_lfsr[6:1]};
        end
    end

    always @(posedge CLK) begin
        if (RESET) begin
            ADDRH <= 8'd80;
            ADDRV <= 7'd60;
        end
        else if (TARGET_REACHED) begin
            // X must be 0-159
            if (horz_lfsr < 8'd160)
                ADDRH <= horz_lfsr;
            else
                ADDRH <= horz_lfsr - 8'd160;
            
            // Y must be 0-119
            if (vert_lfsr < 7'd120)
                ADDRV <= vert_lfsr;
            else
                ADDRV <= vert_lfsr - 7'd120;
        end
    end

endmodule
