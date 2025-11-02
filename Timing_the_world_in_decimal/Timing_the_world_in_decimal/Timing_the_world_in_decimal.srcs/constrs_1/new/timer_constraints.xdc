## Clock signal (100 MHz)
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { CLK }];
create_clock -period 10.00 -name CLK -waveform {0 5} [get_ports { CLK }];

## Push button for RESET (BTNC)
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports { RESET }];

## Slide switch for ENABLE (SW0)
set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports { ENABLE }];

## SEG_SELECT[3:0] - Active Low (anodes)
set_property -dict { PACKAGE_PIN U2  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[0] }];
set_property -dict { PACKAGE_PIN U4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[1] }];
set_property -dict { PACKAGE_PIN V4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[2] }];
set_property -dict { PACKAGE_PIN W4  IOSTANDARD LVCMOS33 } [get_ports { SEG_SELECT[3] }];

## --------------------------------------------------------------

## DEC_OUT[6:0] - Active Low (segments A-G)
set_property -dict { PACKAGE_PIN U7  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[6] }];
set_property -dict { PACKAGE_PIN V5  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[5] }];
set_property -dict { PACKAGE_PIN U5  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[4] }];
set_property -dict { PACKAGE_PIN V8  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[3] }];
set_property -dict { PACKAGE_PIN U8  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[2] }];
set_property -dict { PACKAGE_PIN W6  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[1] }];
set_property -dict { PACKAGE_PIN W7  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[0] }];

## Optional - decimal point (if used inside Seg7Decoder as part of DEC_OUT)
# set_property -dict { PACKAGE_PIN U8  IOSTANDARD LVCMOS33 } [get_ports { DEC_OUT[7] }]; # DP

## ============================================================================

## Optional: LED for heartbeat or debugging (use if you connect a test output)
## set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { LED0 }];

## ============================================================================
