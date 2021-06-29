import gtype::xgmii32_t;
import gtype::xgmii64_t;

module dut
(
    input wire clk_ref,
    input wire rst_ref,
    input wire clk_glbl,
    input wire rst_glbl,
    xgmii_if.DutTx pmaTx,
    xgmii_if.DutRx pmaRx
);

wire        tr_pma_wrapper_clk_glbl_w  ; 
wire        tr_pma_wrapper_rst_glbl_w  ; 
wire        tr_pma_wrapper_refclk_w    ; 
wire        tr_pma_wrapper_rx_serial_w ; 
wire        tr_pma_wrapper_tx_serial_w ; 
wire [31:0] tr_pma_wrapper_pma_tx_w    ; 
wire        tr_pma_wrapper_pma_tx_rdy_w; 
wire        tr_pma_wrapper_pma_tx_clk_w; 
wire        tr_pma_wrapper_pma_slip_w  ; 
wire [31:0] tr_pma_wrapper_pma_rx_w    ; 
wire        tr_pma_wrapper_pma_rx_rdy_w; 
wire        tr_pma_wrapper_pma_rx_clk_w; 

wire        pcs_rx_32b_clk_w     ;
wire        pcs_rx_32b_rst_w     ;
wire [31:0] pcs_rx_32b_pma_data_w;
wire        pcs_rx_32b_pma_slip_w;
wire        pcs_rx_32b_pma_sync_w;
xgmii32_t   pcs_rx_32b_xgmii_rx_w;

wire        pcs_tx_32b_clk_w     ;
wire        pcs_tx_32b_rst_w     ;
xgmii32_t   pcs_tx_32b_xgmii_tx_w;
wire [31:0] pcs_tx_32b_pma_data_w;

reg         force_linkdown_pma   = 0;

//////////////////////////////////////////////////////////////////////////
reg pmaTx_rst = 1; always @(posedge tr_pma_wrapper_pma_tx_clk_w) pmaTx_rst <= !(tr_pma_wrapper_pma_tx_rdy_w); 
reg pmaTx_rdy = 0; always @(posedge tr_pma_wrapper_pma_tx_clk_w) pmaTx_rdy <=  (tr_pma_wrapper_pma_tx_rdy_w & pcs_rx_32b_pma_sync_w); 

assign pmaTx.clk  = tr_pma_wrapper_pma_tx_clk_w;
assign pmaTx.rst  = pmaTx_rst;
assign pmaTx.rdy  = pmaTx_rdy;

assign pmaRx.clk  = tr_pma_wrapper_pma_rx_clk_w;
assign pmaRx.rst  = !tr_pma_wrapper_pma_rx_rdy_w;
assign pmaRx.data = pcs_rx_32b_xgmii_rx_w.data;
assign pmaRx.ctrl = pcs_rx_32b_xgmii_rx_w.ctrl;
assign pmaRx.ena  = pcs_rx_32b_xgmii_rx_w.ena ;
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign tr_pma_wrapper_clk_glbl_w   = clk_glbl;
assign tr_pma_wrapper_rst_glbl_w   = rst_glbl;
assign tr_pma_wrapper_refclk_w     = clk_ref;
assign tr_pma_wrapper_rx_serial_w  = tr_pma_wrapper_tx_serial_w | force_linkdown_pma;
assign tr_pma_wrapper_pma_tx_w     = pcs_tx_32b_pma_data_w;
assign tr_pma_wrapper_pma_slip_w   = pcs_rx_32b_pma_slip_w;

tr_pma_wrapper tr_pma_wrapper_u
(
    .clk_glbl   (tr_pma_wrapper_clk_glbl_w   ),// input  
    .rst_glbl   (tr_pma_wrapper_rst_glbl_w   ),// input  
    .refclk     (tr_pma_wrapper_refclk_w     ),// input  
    .rx_serial  (tr_pma_wrapper_rx_serial_w  ),// input  
    .tx_serial  (tr_pma_wrapper_tx_serial_w  ),// output 
    .pma_tx     (tr_pma_wrapper_pma_tx_w     ),// input  
    .pma_tx_rdy (tr_pma_wrapper_pma_tx_rdy_w ),// output 
    .pma_tx_clk (tr_pma_wrapper_pma_tx_clk_w ),// output 
    .pma_slip   (tr_pma_wrapper_pma_slip_w   ),// input  
    .pma_rx     (tr_pma_wrapper_pma_rx_w     ),// output 
    .pma_rx_rdy (tr_pma_wrapper_pma_rx_rdy_w ),// output 
    .pma_rx_clk (tr_pma_wrapper_pma_rx_clk_w ) // output 
);
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign pcs_rx_32b_clk_w      = tr_pma_wrapper_pma_rx_clk_w; 
assign pcs_rx_32b_rst_w      = 0;
assign pcs_rx_32b_pma_data_w = tr_pma_wrapper_pma_rx_w;

pcs_rx_32b pcs_rx_32b_u
(
    .clk      (pcs_rx_32b_clk_w     ),//input  
    .rst      (pcs_rx_32b_rst_w     ),//input 
    .pma_data (pcs_rx_32b_pma_data_w),//input 
    .pma_slip (pcs_rx_32b_pma_slip_w),//output
    .pma_sync (pcs_rx_32b_pma_sync_w),//output
    .xgmii_rx (pcs_rx_32b_xgmii_rx_w) //output
);
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign pcs_tx_32b_clk_w      = tr_pma_wrapper_pma_tx_clk_w;
assign pcs_tx_32b_rst_w      = 0;
assign pcs_tx_32b_xgmii_tx_w = {pmaTx.ena,pmaTx.ctrl,pmaTx.data};

pcs_tx_32b pcs_tx_32b_u
(
    .clk      (pcs_tx_32b_clk_w     ),//input  
    .rst      (pcs_tx_32b_rst_w     ),//input 
    .xgmii_tx (pcs_tx_32b_xgmii_tx_w),//input 
    .pma_data (pcs_tx_32b_pma_data_w) //output
);
//////////////////////////////////////////////////////////////////////////

endmodule
