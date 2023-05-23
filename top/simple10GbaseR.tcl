package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "simple10GbaseR"]} {
		puts "Project simple10GbaseR is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists simple10GbaseR]} {
		project_open -revision simple10GbaseR simple10GbaseR
	} else {
		project_new -revision simple10GbaseR simple10GbaseR
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 19.4.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "11:13:03  MAY 04, 2019"
	set_global_assignment -name LAST_QUARTUS_VERSION "19.4.0 Pro Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
	set_global_assignment -name DEVICE 10AX090R4F40E3SG
	set_global_assignment -name FAMILY "Arria 10"
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 2
	set_global_assignment -name POWER_AUTO_COMPUTE_TJ ON
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"

	set_global_assignment -name OPTIMIZATION_MODE "SUPERIOR PERFORMANCE WITH MAXIMUM PLACEMENT EFFORT"
	set_global_assignment -name OPTIMIZE_POWER_DURING_SYNTHESIS OFF
	set_global_assignment -name SYNTH_MESSAGE_LEVEL HIGH
	set_global_assignment -name DISABLE_REGISTER_MERGING_ACROSS_HIERARCHIES ON
	set_global_assignment -name ROUTER_CLOCKING_TOPOLOGY_ANALYSIS ON
	set_global_assignment -name PLACEMENT_EFFORT_MULTIPLIER 16.0
	set_global_assignment -name PROGRAMMABLE_POWER_TECHNOLOGY_SETTING "FORCE ALL TILES WITH FAILING TIMING PATHS TO HIGH SPEED"
	set_global_assignment -name FINAL_PLACEMENT_OPTIMIZATION ALWAYS
	set_global_assignment -name FITTER_AGGRESSIVE_ROUTABILITY_OPTIMIZATION ALWAYS
	set_global_assignment -name PERIPHERY_TO_CORE_PLACEMENT_AND_ROUTING_OPTIMIZATION OFF
    set_global_assignment -name ENABLE_INTERMEDIATE_SNAPSHOTS ON
	set_global_assignment -name ALM_REGISTER_PACKING_EFFORT HIGH
    set_global_assignment -name ALLOW_REGISTER_RETIMING ON   
    set_global_assignment -name DISABLE_REGISTER_MERGING_ACROSS_HIERARCHIES AUTO 
    set_global_assignment -name OPTIMIZATION_TECHNIQUE BALANCED
    set_global_assignment -name MUX_RESTRUCTURE AUTO        

    set_location_assignment PIN_G19 -to sys_clk
    set_location_assignment PIN_H19 -to "sys_clk(n)"
    set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL -to sys_clk
    set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL -to "sys_clk(n)"
    set_instance_assignment -name IO_STANDARD LVDS -to sys_clk   
    
    set_instance_assignment -name IO_STANDARD LVDS -to ref_clk
    set_location_assignment PIN_N7 -to ref_clk

    for {set p 0} {$p<2} {incr p} {
        #rx
        set_instance_assignment -name XCVR_A10_RX_TERM_SEL R_R1 -to serial_rx\[$p\]
        set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to serial_rx\[$p\]
        set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to serial_rx\[$p\]
        set_instance_assignment -name XCVR_A10_RX_ADP_VGA_SEL RADP_VGA_SEL_4 -to serial_rx\[$p\]
        set_instance_assignment -name XCVR_A10_RX_ONE_STAGE_ENABLE NON_S1_MODE -to serial_rx\[$p\]
        set_instance_assignment -name XCVR_A10_RX_EQ_DC_GAIN_TRIM NO_DC_GAIN -to serial_rx\[$p\]

        set_instance_assignment -name XCVR_A10_RX_ADP_CTLE_ACGAIN_4S RADP_CTLE_ACGAIN_4S_8 -to serial_rx\[$p\]

        #tx
        set_instance_assignment -name XCVR_A10_TX_TERM_SEL R_R1 -to serial_tx\[$p\]
        set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to serial_tx\[$p\]
        set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to serial_tx\[$p\]
        set_instance_assignment -name XCVR_A10_TX_VOD_OUTPUT_SWING_CTRL 31 -to serial_tx\[$p\]
    }

    set_location_assignment PIN_H5 -to serial_rx[0]
    set_location_assignment PIN_D1 -to serial_tx[0]
    set_location_assignment PIN_K5 -to serial_rx[1]
    set_location_assignment PIN_E3 -to serial_tx[1]
    set_location_assignment PIN_L3 -to serial_rx[2]
    set_location_assignment PIN_F1 -to serial_tx[2]

    set_global_assignment -name SDC_FILE simple10GbaseR.sdc
	
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/gtype.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/sync.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/pcs_tx_32b/pcs_tx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/descrambler_rx_32b/descrambler_rx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/clk_rst/clk_rst.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/scrambler_tx_32b/scrambler_tx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/tr_pma_wrapper/tr_pma_wrapper.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/decoder_rx_32b/decoder_rx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/xgmii_retransmit_32b32b_fifo/xgmii_retransmit_32b32b_fifo.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/xgmii_retransmit_32b64b_fifo/xgmii_retransmit_32b64b_fifo.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/pcs_rx_32b/pcs_rx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/gearbox_tx_32b/gearbox_tx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/align_rx_32b/align_rx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/blsync_rx/blsync_rx.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/tr_baser_wrapper/tr_baser_wrapper.sv
    set_global_assignment -name SYSTEMVERILOG_FILE ../lib/encoder_tx_32b/encoder_tx_32b.sv
    set_global_assignment -name SYSTEMVERILOG_FILE simple10GbaseR.sv

    set_global_assignment -name IP_FILE ../ip/fifo_xgmii_retransmit_32b32b.ip
    set_global_assignment -name IP_FILE ../ip/fifo_xgmii_retransmit_64b64b.ip
    set_global_assignment -name IP_FILE ../ip/pll_644_156.ip
    set_global_assignment -name IP_FILE ../ip/tr_10g_baser.ip
    set_global_assignment -name IP_FILE ../ip/tr_10g_pma.ip
    set_global_assignment -name IP_FILE ../ip/tr_fpll.ip
    set_global_assignment -name IP_FILE ../ip/tr_rst.ip
    
    for {set p 0} {$p<2} {incr p} {
        set_instance_assignment -name PARTITION pcs_rx_32b_$p -to PCSRX\[$p\].PMA.pcs_rx_32b_u -entity simple10GbaseR
        set_instance_assignment -name PARTITION_COLOUR 4289724382 -to PCSRX\[$p\].PMA.pcs_rx_32b_u -entity simple10GbaseR
        set_instance_assignment -name PARTITION pcs_tx_32b_$p -to PCSTX\[$p\].PMA.pcs_tx_32b_u -entity simple10GbaseR
        set_instance_assignment -name PARTITION_COLOUR 4294947502 -to PCSTX\[$p\].PMA.pcs_tx_32b_u -entity simple10GbaseR
    }

    export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
