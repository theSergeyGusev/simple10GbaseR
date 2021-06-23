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

wire        descrambler_rx_32b_clk_w    ;   
wire        descrambler_rx_32b_rst_w    ;   
wire [31:0] descrambler_rx_32b_din_w    ;   
wire [ 1:0] descrambler_rx_32b_ctrlin_w ;   
wire        descrambler_rx_32b_din_en_w ;
wire        descrambler_rx_32b_evenin_w ;
wire [31:0] descrambler_rx_32b_dout_w   ;  
wire [ 1:0] descrambler_rx_32b_ctrlout_w;
wire        descrambler_rx_32b_dout_en_w;
wire        descrambler_rx_32b_evenout_w;

wire        decoder_rx_32b_clk_w     ;  
wire        decoder_rx_32b_rst_w     ; 
wire [31:0] decoder_rx_32b_din_w     ;
wire [ 1:0] decoder_rx_32b_ctrlin_w  ;
wire        decoder_rx_32b_din_en_w  ;
wire        decoder_rx_32b_even_w    ;
wire [31:0] decoder_rx_32b_dout_w    ;
wire [ 3:0] decoder_rx_32b_ctrlout_w ;
wire        decoder_rx_32b_dout_en_w ;

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

////////////////////////////////////////////////////////////////////////////////
assign descrambler_rx_32b_clk_w     = clk                     ;  
assign descrambler_rx_32b_din_w     = align_rx_32b_dout_w     ; 
assign descrambler_rx_32b_ctrlin_w  = align_rx_32b_ctrl_w     ; 
assign descrambler_rx_32b_din_en_w  = align_rx_32b_dout_en_w  ;
assign descrambler_rx_32b_evenin_w  = align_rx_32b_even_w     ;

descrambler_rx_32b descrambler_rx_32b_u
(
    .clk    (descrambler_rx_32b_clk_w     ),// input
    .din    (descrambler_rx_32b_din_w     ),// input
    .ctrlin (descrambler_rx_32b_ctrlin_w  ),// input
    .din_en (descrambler_rx_32b_din_en_w  ),// input
    .evenin (descrambler_rx_32b_evenin_w  ),// input
    .dout   (descrambler_rx_32b_dout_w    ),// output
    .ctrlout(descrambler_rx_32b_ctrlout_w ),// output
    .dout_en(descrambler_rx_32b_dout_en_w ),// output
    .evenout(descrambler_rx_32b_evenout_w ) // output
);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
reg rst_decoder_r = 1;
always @(posedge clk) rst_decoder_r <= !blsync_rx_block_lock_w;

assign decoder_rx_32b_clk_w     = clk                           ;  
assign decoder_rx_32b_rst_w     = rst_decoder_r                 ;
assign decoder_rx_32b_din_w     = descrambler_rx_32b_dout_w     ;
assign decoder_rx_32b_ctrlin_w  = descrambler_rx_32b_ctrlout_w  ;
assign decoder_rx_32b_din_en_w  = descrambler_rx_32b_dout_en_w  ;
assign decoder_rx_32b_even_w    = descrambler_rx_32b_evenout_w  ;

decoder_rx_32b decoder_rx_32b_u
(
    .clk     (decoder_rx_32b_clk_w     ),
    .rst     (decoder_rx_32b_rst_w     ),
    .din     (decoder_rx_32b_din_w     ),
    .ctrlin  (decoder_rx_32b_ctrlin_w  ),
    .din_en  (decoder_rx_32b_din_en_w  ),
    .even    (decoder_rx_32b_even_w    ),
    .dout    (decoder_rx_32b_dout_w    ),
    .ctrlout (decoder_rx_32b_ctrlout_w ),
    .dout_en (decoder_rx_32b_dout_en_w )
);

assign xgmii_rx.data = decoder_rx_32b_dout_w;
assign xgmii_rx.ctrl = decoder_rx_32b_ctrlout_w;
assign xgmii_rx.ena  = decoder_rx_32b_dout_en_w;
//////////////////////////////////////////////////////////////////////////////

endmodule
