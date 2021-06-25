import gtype::xgmii32_t;

module pcs_tx_32b
(
    input wire clk,
    input wire rst,

    input xgmii32_t xgmii_tx,
    
    output wire [31:0] pma_data
);

wire        encoder_tx_32b_clk_w      ; 
wire        encoder_tx_32b_rst_w      ; 
wire [31:0] encoder_tx_32b_din_w      ; 
wire [3:0]  encoder_tx_32b_ctrlin_w   ; 
wire        encoder_tx_32b_din_en_w   ; 
wire [31:0] encoder_tx_32b_dout_w     ; 
wire [ 1:0] encoder_tx_32b_ctrlout_w  ; 
wire        encoder_tx_32b_dout_en_w  ; 
wire        encoder_tx_32b_dout_even_w;

wire        scrambler_tx_32b_clk_w    ;   
wire        scrambler_tx_32b_rst_w    ;   
wire [31:0] scrambler_tx_32b_din_w    ;   
wire [ 1:0] scrambler_tx_32b_ctrlin_w ;   
wire        scrambler_tx_32b_din_en_w ;
wire        scrambler_tx_32b_evenin_w ;
wire [31:0] scrambler_tx_32b_dout_w   ;  
wire [ 1:0] scrambler_tx_32b_ctrlout_w;
wire        scrambler_tx_32b_dout_en_w;
wire        scrambler_tx_32b_evenout_w;

wire        gearbox_tx_32b_clk_w   ; 
wire        gearbox_tx_32b_rst_w   ; 
wire [31:0] gearbox_tx_32b_din_w   ; 
wire [1:0]  gearbox_tx_32b_ctrl_w  ; 
wire        gearbox_tx_32b_din_en_w; 
wire        gearbox_tx_32b_even_w  ; 
wire [31:0] gearbox_tx_32b_dout_w  ; 

////////////////////////////////////////////////////////////////////////////////
assign encoder_tx_32b_clk_w    = clk;
assign encoder_tx_32b_rst_w    = rst;
assign encoder_tx_32b_din_w    = xgmii_tx.data; 
assign encoder_tx_32b_ctrlin_w = xgmii_tx.ctrl;
assign encoder_tx_32b_din_en_w = xgmii_tx.ena;

encoder_tx_32b encoder_tx_32b_u
(
    .clk      (encoder_tx_32b_clk_w      ),
    .rst      (encoder_tx_32b_rst_w      ),
    .din      (encoder_tx_32b_din_w      ),
    .ctrlin   (encoder_tx_32b_ctrlin_w   ),
    .din_en   (encoder_tx_32b_din_en_w   ),
    .dout     (encoder_tx_32b_dout_w     ),
    .ctrlout  (encoder_tx_32b_ctrlout_w  ),
    .dout_en  (encoder_tx_32b_dout_en_w  ),
    .even     (encoder_tx_32b_dout_even_w)
);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign scrambler_tx_32b_clk_w     = clk                       ;  
assign scrambler_tx_32b_din_w     = encoder_tx_32b_dout_w     ; 
assign scrambler_tx_32b_ctrlin_w  = encoder_tx_32b_ctrlout_w  ; 
assign scrambler_tx_32b_din_en_w  = encoder_tx_32b_dout_en_w  ;
assign scrambler_tx_32b_evenin_w  = encoder_tx_32b_dout_even_w;

scrambler_tx_32b scrambler_tx_32b_u
(
    .clk    (scrambler_tx_32b_clk_w     ),
    .din    (scrambler_tx_32b_din_w     ),
    .ctrlin (scrambler_tx_32b_ctrlin_w  ),
    .din_en (scrambler_tx_32b_din_en_w  ),
    .evenin (scrambler_tx_32b_evenin_w  ),
    .dout   (scrambler_tx_32b_dout_w    ),
    .ctrlout(scrambler_tx_32b_ctrlout_w ),
    .dout_en(scrambler_tx_32b_dout_en_w ),
    .evenout(scrambler_tx_32b_evenout_w )
);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign gearbox_tx_32b_clk_w    = clk                        ; 
assign gearbox_tx_32b_rst_w    = rst                        ;
assign gearbox_tx_32b_din_w    = scrambler_tx_32b_dout_w    ;
assign gearbox_tx_32b_ctrl_w   = scrambler_tx_32b_ctrlout_w ;
assign gearbox_tx_32b_din_en_w = scrambler_tx_32b_dout_en_w ;
assign gearbox_tx_32b_even_w   = scrambler_tx_32b_evenout_w ;

gearbox_tx_32b gearbox_tx_32b_u
(
    .clk     (gearbox_tx_32b_clk_w    ),
    .rst     (gearbox_tx_32b_rst_w    ),
    .din     (gearbox_tx_32b_din_w    ),
    .ctrl    (gearbox_tx_32b_ctrl_w   ),
    .din_en  (gearbox_tx_32b_din_en_w ),
    .even    (gearbox_tx_32b_even_w   ),
    .dout    (gearbox_tx_32b_dout_w   )
);
////////////////////////////////////////////////////////////////////////////////

assign pma_data = gearbox_tx_32b_dout_w ;

endmodule
