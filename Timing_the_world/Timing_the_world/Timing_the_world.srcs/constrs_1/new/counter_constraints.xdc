#Clock
set_property PACKAGE_PIN W5 [get_ports {CLK}]
    set_property IOSTANDARD LVCMOS33 [get_ports {CLK}]
    create_clock -period 10.000 -name sys_clk -waveform {0 5} [get_ports {CLK}]
    
#Reset
set_property PACKAGE_PIN U18 [get_ports {RESET}]
    set_property IOSTANDARD LVCMOS33 [get_ports {RESET}]
    
#Count Enable
set_property PACKAGE_PIN V17 [get_ports {COUNT_ENABLE}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COUNT_ENABLE}]

#Count Control
set_property PACKAGE_PIN V16 [get_ports {COUNT_CONTROL}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COUNT_CONTROL}]

#LEDS
set_property PACKAGE_PIN U16 [get_ports {OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[0]}]
set_property PACKAGE_PIN E19 [get_ports {OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[1]}]
set_property PACKAGE_PIN U19 [get_ports {OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[2]}]
set_property PACKAGE_PIN V19 [get_ports {OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[3]}]
set_property PACKAGE_PIN W18 [get_ports {OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[4]}]
set_property PACKAGE_PIN U15 [get_ports {OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[5]}]
set_property PACKAGE_PIN U14 [get_ports {OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[6]}]
set_property PACKAGE_PIN V14 [get_ports {OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {OUT[7]}]