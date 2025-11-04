## Clock signal (100 MHz)
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { CLK }];
create_clock -period 10.00 -name CLK -waveform {0 5} [get_ports { CLK }];

## Push button for RESET (BTNC)
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports { RESET }];

## Push buttons for INPUTS (BTNL, BTNC, BTNR)
set_property -dict { PACKAGE_PIN W19  IOSTANDARD LVCMOS33 } [get_ports { BTNL }]; # BTNL
set_property -dict { PACKAGE_PIN T17  IOSTANDARD LVCMOS33 } [get_ports { BTNR }]; # BTNR  
set_property -dict { PACKAGE_PIN T18  IOSTANDARD LVCMOS33 } [get_ports { BTNU }]; # BTNL
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { BTND }]; # BTNC


## SEG_SELECT[3:0] - Active Low (anodes)
set_property -dict { PACKAGE_PIN U2  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[0] }];
set_property -dict { PACKAGE_PIN U4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[1] }];
set_property -dict { PACKAGE_PIN V4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[2] }];
set_property -dict { PACKAGE_PIN W4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[3] }];

## DEC_OUT[6:0] - Active Low (segments A-G)
set_property -dict { PACKAGE_PIN U7  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[6] }];
set_property -dict { PACKAGE_PIN V5  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[5] }];
set_property -dict { PACKAGE_PIN U5  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[4] }];
set_property -dict { PACKAGE_PIN V8  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[3] }];
set_property -dict { PACKAGE_PIN U8  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[2] }];
set_property -dict { PACKAGE_PIN W6  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[1] }];
set_property -dict { PACKAGE_PIN W7  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[0] }];
set_property -dict { PACKAGE_PIN V7  IOSTANDARD LVCMOS33 } [get_ports { HEX_OUT[7] }]; # DP

#LEDS
set_property PACKAGE_PIN U16 [get_ports {LED_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[3]}]
set_property PACKAGE_PIN W18 [get_ports {LED_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {LED_OUT[7]}]

## VGA interface
set_property -dict { PACKAGE_PIN G19 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[0]]
set_property -dict { PACKAGE_PIN H19 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[1]]
set_property -dict { PACKAGE_PIN J19 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[2]]
set_property -dict { PACKAGE_PIN N19 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[3]]
set_property -dict { PACKAGE_PIN N18 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[4]]
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[5]]
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[6]]
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[7]]
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[8]]
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[9]]
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[10]]
set_property -dict { PACKAGE_PIN D17 IOSTANDARD LVCMOS33 } [get_ports VGA_OUT[11]]

set_property -dict { PACKAGE_PIN P19 IOSTANDARD LVCMOS33 } [get_ports HS]
set_property -dict { PACKAGE_PIN R19 IOSTANDARD LVCMOS33 } [get_ports VS]