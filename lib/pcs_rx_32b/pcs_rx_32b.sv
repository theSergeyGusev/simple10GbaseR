import gtype::xgmii32_t;

module pcs_in_32b
(
    input wire clk,
    input wire rst,

    input wire [31:0] pma_data,
    output wire       pma_slip,
    output wire       pma_sync,

    output xgmii32_t xgmii_rx
);

wire        align_rx_32b_clk_w    ;
wire        align_rx_32b_rst_w    ;
wire [31:0] align_rx_32b_din_w    ;
wire [31:0] align_rx_32b_dout_w   ;
wire [1:0]  align_rx_32b_ctrl_w   ;
wire        align_rx_32b_dout_en_w;       
wire        align_rx_32b_even_w   ;       

wire        blsync_rx_clk_w        ; 
wire        blsync_rx_rst_w        ;
wire [1:0]  blsync_rx_header_w     ;
wire        blsync_rx_header_ena_w ;
wire        blsync_rx_block_lock_w ;
wire        blsync_rx_slp_w        ;

/*
wire        g10_descrambler_clk_w   ;   
wire        g10_descrambler_rst_w   ;   
wire [31:0] g10_descrambler_din_w   ;   
wire [ 1:0] g10_descrambler_ctrlin_w;   
wire        g10_descrambler_din_en_w;
wire        g10_descrambler_evenin_w;
wire [31:0] g10_descrambler_dout_w  ;  
wire [ 1:0] g10_descrambler_ctrlout_w;
wire        g10_descrambler_dout_en_w;
wire        g10_descrambler_evenout_w;

wire        g10_decoder_32b_clk_w     ;  
wire        g10_decoder_32b_rst_w     ; 
wire [31:0] g10_decoder_32b_din_w     ;
wire [ 1:0] g10_decoder_32b_ctrlin_w  ;
wire        g10_decoder_32b_din_en_w  ;
wire        g10_decoder_32b_even_w    ;
wire [31:0] g10_decoder_32b_dout_w    ;
wire [ 3:0] g10_decoder_32b_ctrlout_w ;
wire        g10_decoder_32b_dout_en_w ;
*/
////////////////////////////////////////////////////////////////////////////////
assign align_rx_32b_clk_w  = clk      ; 
assign align_rx_32b_rst_w  = rst      ;
assign align_rx_32b_din_w  = pma_data ;

align_rx_32b align_rx_32b_u
(
    .clk     (align_rx_32b_clk_w    ),
    .rst     (align_rx_32b_rst_w    ),
    .din     (align_rx_32b_din_w    ),
    .dout    (align_rx_32b_dout_w   ),
    .ctrl    (align_rx_32b_ctrl_w   ),
    .dout_en (align_rx_32b_dout_en_w),
    .even    (align_rx_32b_even_w   )
);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign blsync_rx_clk_w        = clk;
assign blsync_rx_rst_w        = rst;
assign blsync_rx_header_w     = align_rx_32b_ctrl_w;
assign blsync_rx_header_ena_w = align_rx_32b_dout_en_w;

blsync_rx blsync_rx_u
(
    .clk       (blsync_rx_clk_w       ),// input 
    .rst       (blsync_rx_rst_w       ),// input 
    .header    (blsync_rx_header_w    ),// input 
    .header_ena(blsync_rx_header_ena_w),// input 
    .block_lock(blsync_rx_block_lock_w),// output
    .slp       (blsync_rx_slp_w       ) // output
);
assign pma_slip = blsync_rx_slp_w;
assign pma_sync = blsync_rx_block_lock_w;
////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
//assign g10_descrambler_clk_w     = clk                      /*clk                                                */ ;  
//assign g10_descrambler_din_w     = g10_blsync_32b_dout_w    /*top.dut_u.g10_pcsout_32b_u.g10_scrambler_u.dout    */ ; 
//assign g10_descrambler_ctrlin_w  = g10_blsync_32b_ctrl_w    /*top.dut_u.g10_pcsout_32b_u.g10_scrambler_u.ctrlout */ ; 
//assign g10_descrambler_din_en_w  = g10_blsync_32b_dout_en_w /*top.dut_u.g10_pcsout_32b_u.g10_scrambler_u.dout_en */ ;
//assign g10_descrambler_evenin_w  = g10_blsync_32b_even_w    /*top.dut_u.g10_pcsout_32b_u.g10_scrambler_u.evenout */ ;
//
//g10_descrambler 
//#(
//    .DATA_WIDTH (32),    
//    .CTRL_WIDTH (2)    
//)
//g10_descrambler_u
//(
//    .clk    (g10_descrambler_clk_w     ),
//    .din    (g10_descrambler_din_w     ),
//    .ctrlin (g10_descrambler_ctrlin_w  ),
//    .din_en (g10_descrambler_din_en_w  ),
//    .evenin (g10_descrambler_evenin_w  ),
//    .dout   (g10_descrambler_dout_w    ),
//    .ctrlout(g10_descrambler_ctrlout_w ),
//    .dout_en(g10_descrambler_dout_en_w ),
//    .evenout(g10_descrambler_evenout_w )
//);
//////////////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////////////
//reg [7:0] rst_decoder_cnt_r = 0;
//reg       rst_decoder_r = 1;
//always @(posedge clk) rst_decoder_cnt_r <= {rst_decoder_cnt_r[6:0],g10_blsync_32b_sync_w};
//always @(posedge clk) rst_decoder_r <= (rst_decoder_cnt_r!='1);
//
//assign g10_decoder_32b_clk_w     = clk                        /*clk                                                  */;  
//assign g10_decoder_32b_rst_w     = rst_decoder_r              /*rst                                                  */;
//assign g10_decoder_32b_din_w     = g10_descrambler_dout_w     /*top.dut_u.g10_pcsout_32b_u.g10_encoder_32b_u.dout    */;
//assign g10_decoder_32b_ctrlin_w  = g10_descrambler_ctrlout_w  /*top.dut_u.g10_pcsout_32b_u.g10_encoder_32b_u.ctrlout */;
//assign g10_decoder_32b_din_en_w  = g10_descrambler_dout_en_w  /*top.dut_u.g10_pcsout_32b_u.g10_encoder_32b_u.dout_en */;
//assign g10_decoder_32b_even_w    = g10_descrambler_evenout_w  /*top.dut_u.g10_pcsout_32b_u.g10_encoder_32b_u.even    */;
//
//g10_decoder_32b g10_decoder_32b_u
//(
//    .clk     (g10_decoder_32b_clk_w     ),
//    .rst     (g10_decoder_32b_rst_w     ),
//    .din     (g10_decoder_32b_din_w     ),
//    .ctrlin  (g10_decoder_32b_ctrlin_w  ),
//    .din_en  (g10_decoder_32b_din_en_w  ),
//    .even    (g10_decoder_32b_even_w    ),
//    .dout    (g10_decoder_32b_dout_w    ),
//    .ctrlout (g10_decoder_32b_ctrlout_w ),
//    .dout_en (g10_decoder_32b_dout_en_w )
//);
//
//assign xgmii_rx.data = g10_decoder_32b_dout_w;
//assign xgmii_rx.ctrl = g10_decoder_32b_ctrlout_w;
//assign xgmii_rx.ena  = g10_decoder_32b_dout_en_w;
////////////////////////////////////////////////////////////////////////////////

endmodule
