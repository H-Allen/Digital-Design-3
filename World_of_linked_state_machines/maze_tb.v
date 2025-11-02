`timescale 1ns/1ps
module tb;
    reg CLK = 0;
    reg RESET = 1;
    reg BTNL = 0, BTNC = 0, BTNR = 0;
    wire [3:0] SEG_SELECT;
    wire [7:0] HEX_OUT;
    wire [7:0] LED_OUT;
    wire [11:0] VGA_OUT;
    wire HS, VS;

    Top_wrapper uut (
        .CLK(CLK),
        .RESET(RESET),
        .BTNL(BTNL),
        .BTNC(BTNC),
        .BTNR(BTNR),
        .SEG_SELECT(SEG_SELECT),
        .HEX_OUT(HEX_OUT),
        .LED_OUT(LED_OUT),
        .VGA_OUT(VGA_OUT),
        .HS(HS),
        .VS(VS)
    );

    always #5 CLK = ~CLK;

    task pulse(input reg signal);
        begin
            signal = 1;
            #10;
            signal = 0;
            #10;
        end
    endtask

    initial begin
        $dumpfile("build/maze.vcd");
        $dumpvars(0, uut);

        // monitor key signals (hierarchical paths)
        $display("time\tRESET MASTER_STATE HS VS ADDRH ADDRV frame_counter COLOUR_IN COLOUR_OUT");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%0d\t%0d\t%0d\t%03h\t%03h",
                 $time,
                 RESET,
                 uut.curr_state,             // Top_wrapper's master state
                 uut.vga_display.HS,
                 uut.vga_display.VS,
                 uut.vga_display.addrh,
                 uut.vga_display.addrv,
                 uut.vga_display.frame_counter,
                 uut.vga_display.colour_next,
                 VGA_OUT);

        #12 RESET = 0;

        // Enter VGA state (press center)
        #20 BTNC = 1; #10 BTNC = 0;

        // Wait long enough for the VGA interface to draw frames.
        // Typical VGA frame is ~16.7 ms for 480p. Simulate e.g. 25 ms = 25_000_000 ns.
        #25000000;

        $finish;
    end
endmodule