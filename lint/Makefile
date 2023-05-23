
SRC = \
	../lib/gtype.sv \
	../lib/sync.sv \
	../ip/fifo_xgmii_retransmit_32b32b/fifo_xgmii_retransmit_32b32b_bb.v \
	../ip/fifo_xgmii_retransmit_64b64b/fifo_xgmii_retransmit_64b64b_bb.v \
	../ip/pll_644_156/pll_644_156_bb.v \
	../ip/tr_10g_baser/tr_10g_baser_bb.v \
	../ip/tr_10g_pma/tr_10g_pma_bb.v \
	../ip/tr_fpll/tr_fpll_bb.v \
	../ip/tr_rst/tr_rst_bb.v \
	../lib/pcs_tx_32b/pcs_tx_32b.sv \
	../lib/descrambler_rx_32b/descrambler_rx_32b.sv \
	../lib/clk_rst/clk_rst.sv \
	../lib/scrambler_tx_32b/scrambler_tx_32b.sv \
	../lib/tr_pma_wrapper/tr_pma_wrapper.sv \
	../lib/decoder_rx_32b/decoder_rx_32b.sv \
	../lib/xgmii_retransmit_32b32b_fifo/xgmii_retransmit_32b32b_fifo.sv \
	../lib/xgmii_retransmit_32b64b_fifo/xgmii_retransmit_32b64b_fifo.sv \
	../lib/pcs_rx_32b/pcs_rx_32b.sv \
	../lib/gearbox_tx_32b/gearbox_tx_32b.sv \
	../lib/align_rx_32b/align_rx_32b.sv \
	../lib/blsync_rx/blsync_rx.sv \
	../lib/tr_baser_wrapper/tr_baser_wrapper.sv \
	../lib/encoder_tx_32b/encoder_tx_32b.sv \
	../top/simple10GbaseR.sv

lint:
	verilator --lint-only --waiver-output cfg_tmp.vlt -Wall -Wpedantic -Wno-EOFNEWLINE $(SRC) --top-module simple10GbaseR cfg.vlt

