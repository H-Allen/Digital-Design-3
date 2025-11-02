module VGA_displaySM (
    input CLK,
    input RESET,
    input [1:0] MASTER_STATE,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS
);

    wire [11:0] colour_out;
    wire [11:0] colour_in;
    wire [9:0]  addrh;  // X coordinate
    wire [8:0]  addrv;  // Y coordinate

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

    // Increate frame_counter every frame
    always @(posedge CLK) begin
        if (RESET) begin
            frame_counter <= 0;
        end
        else if (addrv == 479) begin
            frame_counter <= frame_counter + 1;
        end
    end

    // Colour generation based on MASTER_STATE
    always @(posedge CLK) begin
        if(MASTER_STATE == 2'b10) begin
            if (addrv[8:0] > 240) begin
                if(addrh[9:0] > 320)
                    colour_next <= frame_counter[15:8] + addrv[7:0] + addrh[7:0] - 240 - 320;
                else
                    colour_next <= frame_counter[15:8] + addrv[7:0] - addrh[7:0] - 240 + 320;
            end
            else begin
                if(addrh[9:0] > 320)
                    colour_next <= frame_counter[15:8] - addrv[7:0] + addrh[7:0] + 240 - 320;
                else
                    colour_next <= frame_counter[15:8] - addrv[7:0] - addrh[7:0] + 240 + 320;
            end
        end
        else begin
            colour_next <= 12'h00; // Black background for other states
        end
    end

    assign colour_in = colour_next;
    assign COLOUR_OUT = colour_out;

endmodule
