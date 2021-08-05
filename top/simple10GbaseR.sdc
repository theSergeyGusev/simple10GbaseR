#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3

#**************************************************************
# Create Clock
#**************************************************************

#644,53125MHz
create_clock -period 1.551 [get_ports ref_clk]  

create_clock -period 5.000 [get_ports sys_clk]

derive_pll_clocks
derive_clock_uncertainty

#**************************************************************
# set_false_path 
#**************************************************************
#SYNC MODULE
set_false_path -to [get_registers {*sjy63sd19_sync_r[0]}]

