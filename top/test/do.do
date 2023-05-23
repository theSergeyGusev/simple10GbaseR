add wave -divider #dut_u#
add wave -position end sim:/top/dut_u/clk_ref
add wave -position end sim:/top/dut_u/rst_ref
add wave -position end sim:/top/dut_u/clk_glbl
add wave -position end sim:/top/dut_u/rst_glbl

add wave -divider #clk_rst_u#
add wave -position insertpoint  \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/clk \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/rst \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/clk_glbl \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/rst_glbl \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/refclk \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/tr_fpll_powerdown \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/tr_fpll_pll_locked \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/tr_fpll_tx_serial_clk \
sim:/top/dut_u/simple10GbaseR_u/clk_rst_u/tr_fpll_pll_cal_busy

add wave -divider #pcsrx_0#
add wave -position insertpoint  \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/clk} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/rst} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/pma_data} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/pma_slip} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/pma_sync} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[0]/PMA/pcs_rx_32b_u/xgmii_rx}

add wave -divider #pcsrx_1#
add wave -position insertpoint  \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/clk} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/rst} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/pma_data} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/pma_slip} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/pma_sync} \
{sim:/top/dut_u/simple10GbaseR_u/PCSRX[1]/PMA/pcs_rx_32b_u/xgmii_rx}

run -a
