add wave -divider #dut_u#
add wave -position end sim:/top/dut_u/clk_ref
add wave -position end sim:/top/dut_u/rst_ref
add wave -position end sim:/top/dut_u/clk_glbl
add wave -position end sim:/top/dut_u/rst_glbl

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
