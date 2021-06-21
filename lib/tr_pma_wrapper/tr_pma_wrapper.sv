module tr_pma_wrapper
(
    input  wire clk_glbl,
    input  wire rst_glbl,
    input  wire refclk,
    input  wire rx_serial,
    output wire tx_serial,

    input  wire [31:0] pma_tx,
    output wire        pma_tx_rdy,
    output wire        pma_tx_clk,

    input  wire        pma_slip,
    output wire [31:0] pma_rx,
    output wire        pma_rx_rdy,
    output wire        pma_rx_clk
);

wire tr_rst_clock_w               ;
wire tr_rst_reset_w               ;
wire tr_rst_pll_powerdown0_w      ;
wire tr_rst_tx_analogreset0_w     ;
wire tr_rst_tx_digitalreset0_w    ;
wire tr_rst_tx_ready0_w           ;
wire tr_rst_pll_locked0_w         ;
wire tr_rst_pll_select0_w         ;
wire tr_rst_tx_cal_busy0_w        ;
wire tr_rst_pll_cal_busy0_w       ;
wire tr_rst_rx_analogreset0_w     ;
wire tr_rst_rx_digitalreset0_w    ;
wire tr_rst_rx_ready0_w           ;
wire tr_rst_rx_is_lockedtodata0_w ;
wire tr_rst_rx_cal_busy0_w        ;

wire [0:0]  tr_10g_pma_tx_analogreset_w          ; 
wire [0:0]  tr_10g_pma_tx_digitalreset_w         ; 
wire [0:0]  tr_10g_pma_rx_analogreset_w          ; 
wire [0:0]  tr_10g_pma_rx_digitalreset_w         ; 
wire [0:0]  tr_10g_pma_tx_cal_busy_w             ; 
wire [0:0]  tr_10g_pma_rx_cal_busy_w             ; 
wire [0:0]  tr_10g_pma_tx_serial_clk0_w          ; 
wire        tr_10g_pma_rx_cdr_refclk0_w          ; 
wire [0:0]  tr_10g_pma_tx_serial_data_w          ; 
wire [0:0]  tr_10g_pma_rx_serial_data_w          ; 
wire [0:0]  tr_10g_pma_rx_pma_clkslip_w          ; 
wire [0:0]  tr_10g_pma_rx_is_lockedtoref_w       ; 
wire [0:0]  tr_10g_pma_rx_is_lockedtodata_w      ; 
wire [0:0]  tr_10g_pma_tx_coreclkin_w            ; 
wire [0:0]  tr_10g_pma_rx_coreclkin_w            ; 
wire [0:0]  tr_10g_pma_tx_clkout_w               ; 
wire [0:0]  tr_10g_pma_rx_clkout_w               ; 
wire [31:0] tr_10g_pma_tx_parallel_data_w        ; 
wire [95:0] tr_10g_pma_unused_tx_parallel_data_w ; 
wire [31:0] tr_10g_pma_rx_parallel_data_w        ; 
wire [95:0] tr_10g_pma_unused_rx_parallel_data_w ; 
wire [0:0]  tr_10g_pma_tx_enh_data_valid_w       ; 

wire  tr_fpll_pll_refclk0_w    ;
wire  tr_fpll_pll_powerdown_w  ;
wire  tr_fpll_pll_locked_w     ;
wire  tr_fpll_tx_serial_clk_w  ;
wire  tr_fpll_pll_cal_busy_w   ; 

wire  pll_644_156_pll_refclk0_w   ;
wire  pll_644_156_pll_powerdown_w ;
wire  pll_644_156_pll_locked_w    ;
wire  pll_644_156_outclk0_w       ;
wire  pll_644_156_pll_cal_busy_w  ;

////////////////////////////////////////////////////////////////////////////////
assign tr_rst_clock_w               = clk_glbl                          ;
assign tr_rst_reset_w               = rst_glbl                          ;
assign tr_rst_pll_locked0_w         = tr_fpll_pll_locked_w              ;
assign tr_rst_pll_select0_w         = 0                                 ;
assign tr_rst_tx_cal_busy0_w        = tr_10g_pma_tx_cal_busy_w          ;
assign tr_rst_pll_cal_busy0_w       = tr_fpll_pll_cal_busy_w            ;
assign tr_rst_rx_is_lockedtodata0_w = tr_10g_pma_rx_is_lockedtodata_w   ;
assign tr_rst_rx_cal_busy0_w        = tr_10g_pma_rx_cal_busy_w          ;

tr_rst tr_rst_u
(
    .clock                       (tr_rst_clock_w              ), // input  
    .reset                       (tr_rst_reset_w              ), // input  
    .pll_powerdown0              (tr_rst_pll_powerdown0_w     ), // output 
    .tx_analogreset0             (tr_rst_tx_analogreset0_w    ), // output 
    .tx_digitalreset0            (tr_rst_tx_digitalreset0_w   ), // output 
    .tx_ready0                   (tr_rst_tx_ready0_w          ), // output 
    .pll_locked0                 (tr_rst_pll_locked0_w        ), // input  
    .pll_select0                 (tr_rst_pll_select0_w        ), // input  
    .tx_cal_busy0                (tr_rst_tx_cal_busy0_w       ), // input  
    .pll_cal_busy0               (tr_rst_pll_cal_busy0_w      ), // input  
    .rx_analogreset0             (tr_rst_rx_analogreset0_w    ), // output 
    .rx_digitalreset0            (tr_rst_rx_digitalreset0_w   ), // output 
    .rx_ready0                   (tr_rst_rx_ready0_w          ), // output 
    .rx_is_lockedtodata0         (tr_rst_rx_is_lockedtodata0_w), // input  
    .rx_cal_busy0                (tr_rst_rx_cal_busy0_w       )  // input  
);
assign pma_rx_rdy = tr_rst_rx_ready0_w;
assign pma_tx_rdy = tr_rst_tx_ready0_w;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign tr_10g_pma_tx_analogreset_w          = tr_rst_tx_analogreset0_w  ;
assign tr_10g_pma_tx_digitalreset_w         = tr_rst_tx_digitalreset0_w ;
assign tr_10g_pma_rx_analogreset_w          = tr_rst_rx_analogreset0_w  ;
assign tr_10g_pma_rx_digitalreset_w         = tr_rst_rx_digitalreset0_w ;
assign tr_10g_pma_tx_serial_clk0_w          = tr_fpll_tx_serial_clk_w   ;
assign tr_10g_pma_rx_cdr_refclk0_w          = refclk                    ;
assign tr_10g_pma_rx_serial_data_w          = rx_serial                 ;
assign tr_10g_pma_rx_pma_clkslip_w          = pma_slip                  ;
assign tr_10g_pma_tx_coreclkin_w            = tr_10g_pma_tx_clkout_w    ;
assign tr_10g_pma_rx_coreclkin_w            = tr_10g_pma_rx_clkout_w    ;
assign tr_10g_pma_tx_parallel_data_w        = pma_tx                    ;
assign tr_10g_pma_unused_tx_parallel_data_w = '0                        ;
assign tr_10g_pma_tx_enh_data_valid_w       = 1                         ;

tr_10g_pma tr_10g_pma_u 
(
    .tx_analogreset          (tr_10g_pma_tx_analogreset_w          ), // input  
    .tx_digitalreset         (tr_10g_pma_tx_digitalreset_w         ), // input  
    .rx_analogreset          (tr_10g_pma_rx_analogreset_w          ), // input  
    .rx_digitalreset         (tr_10g_pma_rx_digitalreset_w         ), // input  
    .tx_cal_busy             (tr_10g_pma_tx_cal_busy_w             ), // output 
    .rx_cal_busy             (tr_10g_pma_rx_cal_busy_w             ), // output 
    .tx_serial_clk0          (tr_10g_pma_tx_serial_clk0_w          ), // input  
    .rx_cdr_refclk0          (tr_10g_pma_rx_cdr_refclk0_w          ), // input  
    .tx_serial_data          (tr_10g_pma_tx_serial_data_w          ), // output 
    .rx_serial_data          (tr_10g_pma_rx_serial_data_w          ), // input  
    .rx_pma_clkslip          (tr_10g_pma_rx_pma_clkslip_w          ), // input  
    .rx_is_lockedtoref       (tr_10g_pma_rx_is_lockedtoref_w       ), // output 
    .rx_is_lockedtodata      (tr_10g_pma_rx_is_lockedtodata_w      ), // output 
    .tx_coreclkin            (tr_10g_pma_tx_coreclkin_w            ), // input  
    .rx_coreclkin            (tr_10g_pma_rx_coreclkin_w            ), // input  
    .tx_clkout               (tr_10g_pma_tx_clkout_w               ), // output 
    .rx_clkout               (tr_10g_pma_rx_clkout_w               ), // output 
    .tx_parallel_data        (tr_10g_pma_tx_parallel_data_w        ), // input  
    .unused_tx_parallel_data (tr_10g_pma_unused_tx_parallel_data_w ), // input  
    .rx_parallel_data        (tr_10g_pma_rx_parallel_data_w        ), // output 
    .unused_rx_parallel_data (tr_10g_pma_unused_rx_parallel_data_w ), // output 
    .tx_enh_data_valid       (tr_10g_pma_tx_enh_data_valid_w       )  // input  
) ;

assign tx_serial   = tr_10g_pma_tx_serial_data_w;
assign pma_rx      = tr_10g_pma_rx_parallel_data_w;
assign pma_rx_clk  = tr_10g_pma_rx_clkout_w;
assign pma_tx_clk  = tr_10g_pma_tx_clkout_w;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign tr_fpll_pll_refclk0_w   = refclk;
assign tr_fpll_pll_powerdown_w = tr_rst_pll_powerdown0_w;

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
