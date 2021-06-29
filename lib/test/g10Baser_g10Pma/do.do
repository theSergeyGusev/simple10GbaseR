add wave -divider #dut_u#
add wave -position end sim:/top/dut_u/clk_ref
add wave -position end sim:/top/dut_u/rst_ref
add wave -position end sim:/top/dut_u/clk_glbl
add wave -position end sim:/top/dut_u/rst_glbl
add wave -position end sim:/top/dut_u/force_linkdown_baser
add wave -position end sim:/top/dut_u/force_linkdown_pma  

add wave -divider #tr_baser_wrapper_u#
add wave -position insertpoint  \
sim:/top/dut_u/tr_baser_wrapper_u/clk_glbl \
sim:/top/dut_u/tr_baser_wrapper_u/refclk \
sim:/top/dut_u/tr_baser_wrapper_u/rst_glbl \
sim:/top/dut_u/tr_baser_wrapper_u/rx_serial \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_tx \
sim:/top/dut_u/tr_baser_wrapper_u/rx_sync \
sim:/top/dut_u/tr_baser_wrapper_u/tx_serial \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_rx \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_rx_clk \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_rx_rdy \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_tx_clk \
sim:/top/dut_u/tr_baser_wrapper_u/xgmii_tx_rdy

add wave -divider #tr_10g_baser_u#
add wave -position insertpoint  \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_analogreset \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_digitalreset \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_analogreset \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_digitalreset \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_cal_busy \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_cal_busy \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_serial_clk0 \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_cdr_refclk0 \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_serial_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_serial_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_is_lockedtoref \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_is_lockedtodata \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_coreclkin \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_coreclkin \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_clkout \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_clkout \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_parallel_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_control \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_err_ins \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/unused_tx_parallel_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/unused_tx_control \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_parallel_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_control \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/unused_rx_parallel_data \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/unused_rx_control \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_enh_data_valid \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/tx_enh_fifo_full \
sim:/top/dut_u/tr_baser_wrapper_u/tr_10g_baser_u/rx_enh_blk_lock

add wave -divider #tr_pma_wrapper_u#
add wave -position insertpoint  \
sim:/top/dut_u/tr_pma_wrapper_u/clk_glbl \
sim:/top/dut_u/tr_pma_wrapper_u/pma_slip \
sim:/top/dut_u/tr_pma_wrapper_u/pma_tx \
sim:/top/dut_u/tr_pma_wrapper_u/refclk \
sim:/top/dut_u/tr_pma_wrapper_u/rst_glbl \
sim:/top/dut_u/tr_pma_wrapper_u/rx_serial \
sim:/top/dut_u/tr_pma_wrapper_u/pma_rx \
sim:/top/dut_u/tr_pma_wrapper_u/pma_rx_clk \
sim:/top/dut_u/tr_pma_wrapper_u/pma_rx_rdy \
sim:/top/dut_u/tr_pma_wrapper_u/pma_tx_clk \
sim:/top/dut_u/tr_pma_wrapper_u/pma_tx_rdy \
sim:/top/dut_u/tr_pma_wrapper_u/tx_serial

add wave -divider #pcs_rx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_rx_32b_u/clk \
sim:/top/dut_u/pcs_rx_32b_u/pma_data \
sim:/top/dut_u/pcs_rx_32b_u/rst \
sim:/top/dut_u/pcs_rx_32b_u/pma_slip \
sim:/top/dut_u/pcs_rx_32b_u/pma_sync \
sim:/top/dut_u/pcs_rx_32b_u/xgmii_rx

add wave -divider #align_rx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/clk \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/din \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/rst \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/ctrl \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/dout \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/dout_en \
sim:/top/dut_u/pcs_rx_32b_u/align_rx_32b_u/even

add wave -divider #blsync_rx_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/clk \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/header \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/header_ena \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/rst \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/block_lock \
sim:/top/dut_u/pcs_rx_32b_u/blsync_rx_u/slp

add wave -divider #descrambler_rx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/clk \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/ctrlin \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/din \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/din_en \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/evenin \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/ctrlout \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/dout \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/dout_en \
sim:/top/dut_u/pcs_rx_32b_u/descrambler_rx_32b_u/evenout

add wave -divider #decoder_rx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/clk \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/ctrlin \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/din \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/din_en \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/even \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/rst \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/ctrlout \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/dout \
sim:/top/dut_u/pcs_rx_32b_u/decoder_rx_32b_u/dout_en

add wave -divider #pcs_tx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_tx_32b_u/clk \
sim:/top/dut_u/pcs_tx_32b_u/rst \
sim:/top/dut_u/pcs_tx_32b_u/xgmii_tx \
sim:/top/dut_u/pcs_tx_32b_u/pma_data

add wave -divider #encoder_tx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/clk \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/rst \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/din \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/ctrlin \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/din_en \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/dout \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/ctrlout \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/dout_en \
sim:/top/dut_u/pcs_tx_32b_u/encoder_tx_32b_u/even

add wave -divider #scrambler_tx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/clk \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/din \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/ctrlin \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/din_en \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/evenin \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/dout \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/ctrlout \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/dout_en \
sim:/top/dut_u/pcs_tx_32b_u/scrambler_tx_32b_u/evenout

add wave -divider #gearbox_tx_32b_u#
add wave -position insertpoint  \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/clk \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/rst \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/din \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/ctrl \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/din_en \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/even \
sim:/top/dut_u/pcs_tx_32b_u/gearbox_tx_32b_u/dout



run -a
