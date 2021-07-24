add wave -divider #dut_u#
add wave -position end sim:/top/dut_u/clk_rx
add wave -position end sim:/top/dut_u/rst_rx
add wave -position end sim:/top/dut_u/clk_tx
add wave -position end sim:/top/dut_u/rst_tx
add wave -divider ##

add wave -divider #xgmii_retransmit_32b32b_fifo_u#
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/clk_rx    
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/rx        
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/clk_tx    
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/tx        

add wave -divider #fifo_xgmii_retransmit_32b32b_u#
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/wrclk       
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/wrreq       
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/data        
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/wrfull      
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/rdclk       
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/rdreq       
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/q           
add wave -position end sim:/top/dut_u/xgmii_retransmit_32b32b_fifo_u/fifo_xgmii_retransmit_32b32b_u/rdempty     

run -a
