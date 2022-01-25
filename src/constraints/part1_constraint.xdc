## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches

## digit values switch 0-3
set_property PACKAGE_PIN V17 [get_ports {digitValue[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digitValue[0]}]
set_property PACKAGE_PIN V16 [get_ports {digitValue[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digitValue[1]}]
set_property PACKAGE_PIN W16 [get_ports {digitValue[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digitValue[2]}]
set_property PACKAGE_PIN W17 [get_ports {digitValue[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digitValue[3]}]
	
## enable switch-4
set_property PACKAGE_PIN W15 [get_ports {enWrite}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enWrite}]
	
## regLoad switch-5
set_property PACKAGE_PIN V15 [get_ports {regLoad}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regLoad}]

## register selection switich 6-7
set_property PACKAGE_PIN W14 [get_ports {regSelection[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regSelection[0]}]
set_property PACKAGE_PIN W13 [get_ports {regSelection[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regSelection[1]}]
set_property PACKAGE_PIN V2 [get_ports {regSelection[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regSelection[2]}]
	
## reset - switch 13
set_property PACKAGE_PIN U1 [get_ports {reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
	
## digit location switch 14-15
set_property PACKAGE_PIN T1 [get_ports {digLocation[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digLocation[0]}]
set_property PACKAGE_PIN R2 [get_ports {digLocation[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digLocation[1]}]
 
## LEDs
set_property PACKAGE_PIN U16 [get_ports {regContent[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[0]}]
set_property PACKAGE_PIN E19 [get_ports {regContent[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[1]}]
set_property PACKAGE_PIN U19 [get_ports {regContent[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[2]}]
set_property PACKAGE_PIN V19 [get_ports {regContent[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[3]}]
set_property PACKAGE_PIN W18 [get_ports {regContent[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[4]}]
set_property PACKAGE_PIN U15 [get_ports {regContent[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[5]}]
set_property PACKAGE_PIN U14 [get_ports {regContent[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[6]}]
set_property PACKAGE_PIN V14 [get_ports {regContent[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[7]}]
set_property PACKAGE_PIN V13 [get_ports {regContent[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[8]}]
set_property PACKAGE_PIN V3 [get_ports {regContent[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[9]}]
set_property PACKAGE_PIN W3 [get_ports {regContent[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[10]}]
set_property PACKAGE_PIN U3 [get_ports {regContent[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[11]}]
set_property PACKAGE_PIN P3 [get_ports {regContent[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[12]}]
set_property PACKAGE_PIN N3 [get_ports {regContent[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[13]}]
set_property PACKAGE_PIN P1 [get_ports {regContent[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[14]}]
set_property PACKAGE_PIN L1 [get_ports {regContent[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {regContent[15]}]
	
	
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {a}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a}]
set_property PACKAGE_PIN W6 [get_ports {b}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {b}]
set_property PACKAGE_PIN U8 [get_ports {c}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {c}]
set_property PACKAGE_PIN V8 [get_ports {d}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {d}]
set_property PACKAGE_PIN U5 [get_ports {e}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {e}]
set_property PACKAGE_PIN V5 [get_ports {f}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {f}]
set_property PACKAGE_PIN U7 [get_ports {g}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {g}]

set_property PACKAGE_PIN V7 [get_ports dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


##Buttons
##     1
## 2 start 3
##     4
set_property PACKAGE_PIN U18 [get_ports startGame]						
	set_property IOSTANDARD LVCMOS33 [get_ports startGame]
set_property PACKAGE_PIN T18 [get_ports button1]						
	set_property IOSTANDARD LVCMOS33 [get_ports button1]
set_property PACKAGE_PIN W19 [get_ports button2]						
	set_property IOSTANDARD LVCMOS33 [get_ports button2]
set_property PACKAGE_PIN T17 [get_ports button3]						
	set_property IOSTANDARD LVCMOS33 [get_ports button3]
set_property PACKAGE_PIN U17 [get_ports button4]						
	set_property IOSTANDARD LVCMOS33 [get_ports button4]
	
## constraint for converter
	set_property PACKAGE_PIN A14 [get_ports {rowsOut[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[0]}] 
	set_property PACKAGE_PIN A16 [get_ports {rowsOut[1]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[1]}] 
  	set_property PACKAGE_PIN B15 [get_ports {rowsOut[2]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[2]}] 
  	set_property PACKAGE_PIN B16 [get_ports {rowsOut[3]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[3]}] 
  	set_property PACKAGE_PIN A15 [get_ports {rowsOut[4]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[4]}] 
  	set_property PACKAGE_PIN A17 [get_ports {rowsOut[5]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[5]}] 
  	set_property PACKAGE_PIN C15 [get_ports {rowsOut[6]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[6]}]  
  	set_property PACKAGE_PIN C16 [get_ports {rowsOut[7]}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {rowsOut[7]}]
	set_property PACKAGE_PIN K17 [get_ports {ds}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {ds}]
  	set_property PACKAGE_PIN M18 [get_ports {oe}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {oe}] 
  	set_property PACKAGE_PIN N17 [get_ports {stcp}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {stcp}]  
  	set_property PACKAGE_PIN P18 [get_ports {shcp}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {shcp}] 
  	set_property PACKAGE_PIN L17 [get_ports {mr}]
  	set_property IOSTANDARD LVCMOS33 [get_ports {mr}] 
