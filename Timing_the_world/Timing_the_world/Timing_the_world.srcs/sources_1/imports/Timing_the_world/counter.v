`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2025 12:50:18
// Design Name: 
// Module Name: counter
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

module counter(
    input CLK,
    input COUNT_CONTROL,
    input RESET,
    input COUNT_ENABLE,
    output [7:0] OUT
    );
    
    reg [7:0] Value;
    reg [26:0] Bit_27_counter;
    
    always@(posedge CLK) begin
        if (RESET)
            Bit_27_counter <= 0;
        else begin
            if (COUNT_ENABLE) begin
                if(COUNT_CONTROL) begin
                    if(Bit_27_counter == 100000000)
                        Bit_27_counter <= 0;
                    else
                        Bit_27_counter <= Bit_27_counter + 1;
                    end
                else begin
                    if (Bit_27_counter == 0)
                        Bit_27_counter <= 100000000;
                    else
                        Bit_27_counter <= Bit_27_counter - 1;
                    end
                end
            end
         end
     
     always@(posedge CLK) begin
        if (RESET) begin
            Value <= 0;
        end
        else if (COUNT_ENABLE) begin
            if(Bit_27_counter == 0) begin
                if(COUNT_CONTROL)
                    Value <= Value + 1;
                else
                    Value <= Value - 1;
                end
            end
        end
     assign OUT = Value;
endmodule
