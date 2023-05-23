import gtype::xgmii32_t;
import gtype::xgmii64_t;

module dut
(
    input wire clk_rx,
    input wire clk_tx,
    input wire rst_rx,
    input wire rst_tx,
    xgmii_if.DutTx Tx,
    xgmii_if.DutRx Rx
);

localparam SIMULATION = 1;

wire      xgmii_retransmit_32b64b_fifo_clk_rx_w;
xgmii32_t xgmii_retransmit_32b64b_fifo_rx_w;    
wire      xgmii_retransmit_32b64b_fifo_clk_tx_w;
xgmii64_t xgmii_retransmit_32b64b_fifo_tx_w;    

//////////////////////////////////////////////////////////////////////////
assign Tx.clk = clk_tx;
assign Tx.rst = rst_tx;
assign Tx.rdy = !rst_tx;

assign Rx.clk  = clk_rx;
assign Rx.rst  = rst_rx;
assign Rx.data = xgmii_retransmit_32b64b_fifo_tx_w.data;
assign Rx.ctrl = xgmii_retransmit_32b64b_fifo_tx_w.ctrl;
assign Rx.ena  = xgmii_retransmit_32b64b_fifo_tx_w.ena ;
//////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign xgmii_retransmit_32b64b_fifo_clk_rx_w = clk_tx;
assign xgmii_retransmit_32b64b_fifo_rx_w     = {Tx.ena,Tx.ctrl,Tx.data};
assign xgmii_retransmit_32b64b_fifo_clk_tx_w = clk_rx;

xgmii_retransmit_32b64b_fifo xgmii_retransmit_32b64b_fifo_u
(
    .clk_rx (xgmii_retransmit_32b64b_fifo_clk_rx_w),
    .clk_tx (xgmii_retransmit_32b64b_fifo_clk_tx_w),
    .rx     (xgmii_retransmit_32b64b_fifo_rx_w    ),
    .tx     (xgmii_retransmit_32b64b_fifo_tx_w    )
);
////////////////////////////////////////////////////////////////////////////////

endmodule
