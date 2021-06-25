import gtype::xgmii32_t;
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
    xgmii_if.DutRx baserRx,
    xgmii_if.DutTx pmaTx,
    xgmii_if.DutRx pmaRx
);

wire      tr_baser_wrapper_clk_glbl_w     ; 
wire      tr_baser_wrapper_rst_glbl_w     ; 
wire      tr_baser_wrapper_clk_156_w      ; 
wire      tr_baser_wrapper_rst_156_w      ; 
wire      tr_baser_wrapper_refclk_w       ; 
wire      tr_baser_wrapper_rx_serial_w    ; 
wire      tr_baser_wrapper_tx_serial_w    ; 
xgmii64_t tr_baser_wrapper_xgmii_tx_w     ; 
wire      tr_baser_wrapper_xgmii_tx_rdy_w ; 
wire      tr_baser_wrapper_xgmii_tx_clk_w ; 
wire      tr_baser_wrapper_xgmii_tx_rst_w ; 
xgmii64_t tr_baser_wrapper_xgmii_rx_w     ; 
wire      tr_baser_wrapper_xgmii_rx_rdy_w ; 
wire      tr_baser_wrapper_xgmii_rx_clk_w ; 
wire      tr_baser_wrapper_xgmii_rx_rst_w ; 
wire      tr_baser_wrapper_rx_sync_w      ; 

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

reg         force_linkdown = 0;

//////////////////////////////////////////////////////////////////////////
reg baserTx_rst = 1; always @(posedge tr_baser_wrapper_xgmii_tx_clk_w) baserTx_rst <= !(tr_baser_wrapper_xgmii_tx_rdy_w); 
reg baserTx_rdy = 0; always @(posedge tr_baser_wrapper_xgmii_tx_clk_w) baserTx_rdy <=  (tr_baser_wrapper_xgmii_tx_rdy_w & pcs_rx_32b_pma_sync_w); 

reg pmaTx_rst = 1; always @(posedge tr_pma_wrapper_pma_tx_clk_w) pmaTx_rst <= !(tr_pma_wrapper_pma_tx_rdy_w); 
reg pmaTx_rdy = 0; always @(posedge tr_pma_wrapper_pma_tx_clk_w) pmaTx_rdy <=  (tr_pma_wrapper_pma_tx_rdy_w & tr_baser_wrapper_rx_sync_w); 

assign baserTx.clk = tr_baser_wrapper_xgmii_tx_clk_w;
assign baserTx.rst = baserTx_rst;
assign baserTx.rdy = baserTx_rdy;

assign baserRx.clk  = tr_baser_wrapper_xgmii_rx_clk_w;
assign baserRx.rst  = !tr_baser_wrapper_xgmii_rx_rdy_w;
assign baserRx.data = tr_baser_wrapper_xgmii_rx_w.data;
assign baserRx.ctrl = tr_baser_wrapper_xgmii_rx_w.ctrl;
assign baserRx.ena  = tr_baser_wrapper_xgmii_rx_w.ena ;

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
assign tr_baser_wrapper_clk_glbl_w  = clk_glbl;    
assign tr_baser_wrapper_rst_glbl_w  = rst_glbl;   
assign tr_baser_wrapper_clk_156_w   = clk_156;    
assign tr_baser_wrapper_rst_156_w   = rst_156;   
assign tr_baser_wrapper_refclk_w    = clk_ref;   
assign tr_baser_wrapper_rx_serial_w = tr_pma_wrapper_tx_serial_w;   
assign tr_baser_wrapper_xgmii_tx_w  = {baserTx.ena,baserTx.ctrl,baserTx.data};   

tr_baser_wrapper tr_baser_wrapper_u
(
    .clk_glbl     (tr_baser_wrapper_clk_glbl_w      ),//input    
    .rst_glbl     (tr_baser_wrapper_rst_glbl_w      ),//input   
    .clk_156      (tr_baser_wrapper_clk_156_w       ),//input    
    .rst_156      (tr_baser_wrapper_rst_156_w       ),//input   
    .refclk       (tr_baser_wrapper_refclk_w        ),//input   
    .rx_serial    (tr_baser_wrapper_rx_serial_w     ),//input   
    .tx_serial    (tr_baser_wrapper_tx_serial_w     ),//output  
    .xgmii_tx     (tr_baser_wrapper_xgmii_tx_w      ),//input   
    .xgmii_tx_rdy (tr_baser_wrapper_xgmii_tx_rdy_w  ),//output  
    .xgmii_tx_clk (tr_baser_wrapper_xgmii_tx_clk_w  ),//output  
    .xgmii_tx_rst (tr_baser_wrapper_xgmii_tx_rst_w  ),//output  
    .xgmii_rx     (tr_baser_wrapper_xgmii_rx_w      ),//output  
    .xgmii_rx_rdy (tr_baser_wrapper_xgmii_rx_rdy_w  ),//output  
    .xgmii_rx_clk (tr_baser_wrapper_xgmii_rx_clk_w  ),//output  
    .xgmii_rx_rst (tr_baser_wrapper_xgmii_rx_rst_w  ),//output  
    .rx_sync      (tr_baser_wrapper_rx_sync_w       ) //output  
);
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
assign tr_pma_wrapper_clk_glbl_w   = clk_glbl;
assign tr_pma_wrapper_rst_glbl_w   = rst_glbl;
assign tr_pma_wrapper_refclk_w     = clk_ref;
assign tr_pma_wrapper_rx_serial_w  = tr_baser_wrapper_tx_serial_w;
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
