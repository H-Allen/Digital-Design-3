module BasicSM_mem (
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    output [2:0] STATE_OUT
);

reg [2:0] Next_state_mem[0:63]; // Memory to hold next states
reg [2:0] Current_state;

// Load the ROM configuration from file into 2D array
initial begin
    $readmemb("sm_mem.txt", Next_state_mem);
end

//Simple synchronous system that sets the current state to 0 when RESET else it
//fetches the next state from the memory using the current state and the INPUTS
//BTNL, BTNC, BTNR as the address.
always @(posedge CLK) begin
    if (RESET)
        Current_state <= 3'b000; // Initial State
    else begin
        // Create address from current state and inputs
        Current_state <= Next_state_mem[{Current_state, BTNL, BTNC, BTNR}];
    end
end

assign STATE_OUT = Current_state;
endmodule