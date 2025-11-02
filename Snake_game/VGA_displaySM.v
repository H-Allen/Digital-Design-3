module VGA_displaySM (
    input CLK,
    input RESET,
    input [1:0] MASTER_STATE,
    output [11:0] COLOUR_IN,
    output [11:0] COLOUR_OUT,
    output [9:0] ADDRH,
    output [8:0] ADDRV,
    output HS,
    output VS
);

    parameter IDLE = 2'b00
    parameter PLAY = 2'b01
    parameter WIN = 2'b10

    wire [11:0] colour_in;
    wire [9:0]  addrh;
    wire [8:0]  addrv;

    reg [11:0] colour_next;

    VGA_Interface vga_inst (
            .CLK(CLK),
            .COLOUR_IN(colour_in),
            .COLOUR_OUT(COLOUR_OUT),
            .ADDRH(addrh),
            .ADDRV(addrv),
            .HS(HS),
            .VS(VS)
    );

    always @(*) begin
        case (MASTER_STATE)
            IDLE begin 
                colour_next = 12'h00F
            end
            PLAY begin
                colour_next = COLOUR_IN
            end
            WIN begin
                colour_next = 12'hF00
    end

    assign colour_in = colour_next;
    assign ADDRH = addrh;
    assign ADDRV = addrv;

endmodule
