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

run -a
