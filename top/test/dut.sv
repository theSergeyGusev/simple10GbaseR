import gtype::xgmii64_t;

module dut
(
    input wire clk_ref,
    input wire rst_ref,
    input wire clk_glbl,
    input wire rst_glbl,
    input wire clk_156,
    input wire rst_156,
    xgmii_if.DutTx baserTx,
    xgmii_if.DutRx baserRx
);

localparam NUM_TR = 3;

wire      tr_baser_wrapper_clk_glbl_w              ;
wire      tr_baser_wrapper_rst_glbl_w              ;
wire      tr_baser_wrapper_clk_156_w               ;
wire      tr_baser_wrapper_rst_156_w               ;
wire      tr_baser_wrapper_refclk_w                ;
wire      tr_baser_wrapper_rx_serial_w             ;
wire      tr_baser_wrapper_tx_serial_w             ;
wire      tr_baser_wrapper_tr_fpll_pll_powerdown_w ;
wire      tr_baser_wrapper_tr_fpll_pll_locked_w    ;
wire      tr_baser_wrapper_tr_fpll_tx_serial_clk_w ;
wire      tr_baser_wrapper_tr_fpll_pll_cal_busy_w  ;
xgmii64_t tr_baser_wrapper_xgmii_tx_w              ;
wire      tr_baser_wrapper_xgmii_tx_rdy_w          ;
wire      tr_baser_wrapper_xgmii_tx_clk_w          ;
wire      tr_baser_wrapper_xgmii_tx_rst_w          ;
xgmii64_t tr_baser_wrapper_xgmii_rx_w              ;
wire      tr_baser_wrapper_xgmii_rx_rdy_w          ;
wire      tr_baser_wrapper_xgmii_rx_clk_w          ;
wire      tr_baser_wrapper_xgmii_rx_rst_w          ;
wire      tr_baser_wrapper_rx_sync_w               ;

wire  tr_fpll_pll_refclk0_w    ;
wire  tr_fpll_pll_powerdown_w  ;
wire  tr_fpll_pll_locked_w     ;
wire  tr_fpll_tx_serial_clk_w  ;
wire  tr_fpll_pll_cal_busy_w   ; 

wire simple10GbaseR_serial_rx_w [NUM_TR-1:0];
wire simple10GbaseR_serial_tx_w [NUM_TR-1:0];

//////////////////////////////////////////////////////////////////////////
reg baserTx_rst = 1; always @(posedge tr_baser_wrapper_xgmii_tx_clk_w) baserTx_rst <= !(top.dut_u.simple10GbaseR_u.TR[0].PMA.tr_pma_wrapper_u.pma_tx_rdy); 
reg baserTx_rdy = 0; always @(posedge tr_baser_wrapper_xgmii_tx_clk_w) baserTx_rdy <=  (top.dut_u.simple10GbaseR_u.TR[0].PMA.tr_pma_wrapper_u.pma_tx_rdy & top.dut_u.simple10GbaseR_u.PCSRX[0].PMA.pcs_rx_32b_u.pma_sync & top.dut_u.simple10GbaseR_u.PCSRX[1].PMA.pcs_rx_32b_u.pma_sync); 

assign baserTx.clk = tr_baser_wrapper_xgmii_tx_clk_w;
assign baserTx.rst = baserTx_rst;
assign baserTx.rdy = baserTx_rdy;

assign baserRx.clk  = tr_baser_wrapper_xgmii_rx_clk_w;
assign baserRx.rst  = !tr_baser_wrapper_xgmii_rx_rdy_w;
assign baserRx.data = tr_baser_wrapper_xgmii_rx_w.data;
assign baserRx.ctrl = tr_baser_wrapper_xgmii_rx_w.ctrl;
assign baserRx.ena  = tr_baser_wrapper_xgmii_rx_w.ena ;
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign simple10GbaseR_serial_rx_w[0] = tr_baser_wrapper_tx_serial_w;
assign simple10GbaseR_serial_rx_w[1] = simple10GbaseR_serial_tx_w[1];
assign simple10GbaseR_serial_rx_w[2] = simple10GbaseR_serial_tx_w[2];

simple10GbaseR 
#(.NUM_TR(NUM_TR))
simple10GbaseR_u
(
    .sys_clk   (clk_glbl                  ),
    .ref_clk   (clk_ref                   ), 
    .serial_rx (simple10GbaseR_serial_rx_w),
    .serial_tx (simple10GbaseR_serial_tx_w)
);
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign tr_baser_wrapper_clk_glbl_w              = clk_glbl;
assign tr_baser_wrapper_rst_glbl_w              = rst_glbl;
assign tr_baser_wrapper_clk_156_w               = clk_156;
assign tr_baser_wrapper_rst_156_w               = rst_156;
assign tr_baser_wrapper_refclk_w                = clk_ref;
assign tr_baser_wrapper_rx_serial_w             = simple10GbaseR_serial_tx_w[0];
assign tr_baser_wrapper_tr_fpll_pll_locked_w    = tr_fpll_pll_locked_w;
assign tr_baser_wrapper_tr_fpll_tx_serial_clk_w = tr_fpll_tx_serial_clk_w;
assign tr_baser_wrapper_tr_fpll_pll_cal_busy_w  = tr_fpll_pll_cal_busy_w;
assign tr_baser_wrapper_xgmii_tx_w              = {baserTx.ena,baserTx.ctrl,baserTx.data};

tr_baser_wrapper tr_baser_wrapper_u
(
    .clk_glbl              ( tr_baser_wrapper_clk_glbl_w             ),//input
    .rst_glbl              ( tr_baser_wrapper_rst_glbl_w             ),//input
    .clk_156               ( tr_baser_wrapper_clk_156_w              ),//input
    .rst_156               ( tr_baser_wrapper_rst_156_w              ),//input
    .refclk                ( tr_baser_wrapper_refclk_w               ),//input
    .rx_serial             ( tr_baser_wrapper_rx_serial_w            ),//input
    .tx_serial             ( tr_baser_wrapper_tx_serial_w            ),//output
    .tr_fpll_pll_powerdown ( tr_baser_wrapper_tr_fpll_pll_powerdown_w),//output
    .tr_fpll_pll_locked    ( tr_baser_wrapper_tr_fpll_pll_locked_w   ),//input
    .tr_fpll_tx_serial_clk ( tr_baser_wrapper_tr_fpll_tx_serial_clk_w),//input
    .tr_fpll_pll_cal_busy  ( tr_baser_wrapper_tr_fpll_pll_cal_busy_w ),//input
    .xgmii_tx              ( tr_baser_wrapper_xgmii_tx_w             ),//input
    .xgmii_tx_rdy          ( tr_baser_wrapper_xgmii_tx_rdy_w         ),//output
    .xgmii_tx_clk          ( tr_baser_wrapper_xgmii_tx_clk_w         ),//output
    .xgmii_tx_rst          ( tr_baser_wrapper_xgmii_tx_rst_w         ),//output
    .xgmii_rx              ( tr_baser_wrapper_xgmii_rx_w             ),//output
    .xgmii_rx_rdy          ( tr_baser_wrapper_xgmii_rx_rdy_w         ),//output
    .xgmii_rx_clk          ( tr_baser_wrapper_xgmii_rx_clk_w         ),//output
    .xgmii_rx_rst          ( tr_baser_wrapper_xgmii_rx_rst_w         ),//output
    .rx_sync               ( tr_baser_wrapper_rx_sync_w              ) //output
);
//////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign tr_fpll_pll_refclk0_w   = clk_ref;
assign tr_fpll_pll_powerdown_w = tr_baser_wrapper_tr_fpll_pll_powerdown_w;

tr_fpll tr_fpll_u
(
    .pll_refclk0   (tr_fpll_pll_refclk0_w  ), // input  
    .pll_powerdown (tr_fpll_pll_powerdown_w), // input  
    .pll_locked    (tr_fpll_pll_locked_w   ), // output 
    .tx_serial_clk (tr_fpll_tx_serial_clk_w), // output 
    .pll_cal_busy  (tr_fpll_pll_cal_busy_w )  // output 
    );
////////////////////////////////////////////////////////////////////////////////

endmodule
