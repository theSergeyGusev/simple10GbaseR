module decoder_rx_32b
(
    input wire clk,
    input wire rst,

    input wire [31:0] din,
    input wire [1:0]  ctrlin,
    input wire        din_en,
    input wire        even,

    output wire [31:0] dout,
    output wire [ 3:0] ctrlout,
    output wire        dout_en 
);

reg        dout_en_0r = 0;
reg [31:0] dout_0r    = 0;
reg        dout_en_1r = 0;
reg [31:0] dout_1r    = 0;
reg [31:0] din_r      = 0;
reg [3:0]  ctrlout_0r = 0;
reg [3:0]  ctrlout_1r = 0;
reg        nerr_ctrl_r= 0;

reg detect_idle_1e_0_r      = 0; 
reg detect_ordset_2d_0_r    = 0; 
reg detect_start_33_0_r     = 0; 
reg detect_start_66_0_r     = 0; 
reg detect_ordset_55_0_r    = 0; 
reg detect_start_78_0_r     = 0; 
reg detect_ordset_4b_0_r    = 0; 
reg detect_terminate_87_0_r = 0; 
reg detect_terminate_99_0_r = 0; 
reg detect_terminate_aa_0_r = 0; 
reg detect_terminate_b4_0_r = 0; 
reg detect_terminate_cc_0_r = 0; 
reg detect_terminate_cc_1_r = 0; 
reg detect_terminate_d2_0_r = 0; 
reg detect_terminate_d2_1_r = 0; 
reg detect_terminate_e1_0_r = 0; 
reg detect_terminate_e1_1_r = 0; 
reg detect_terminate_ff_0_r = 0; 
reg detect_terminate_ff_1_r = 0; 

wire detect_idle_1e_0_w       = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h1E);
wire detect_idle_1e_1_w       =           (ctrlin[0]==1'b1)                          & detect_idle_1e_0_r;
wire detect_ordset_2d_0_w     = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h2D); 
wire detect_ordset_2d_1_w     =           (ctrlin[0]==1'b1)                          & detect_ordset_2d_0_r; 
wire detect_start_33_0_w      = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h33);
wire detect_start_33_1_w      =           (ctrlin[0]==1'b1)                          & detect_start_33_0_r;
wire detect_start_66_0_w      = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h66);
wire detect_start_66_1_w      =           (ctrlin[0]==1'b1)                          & detect_start_66_0_r;
wire detect_ordset_55_0_w     = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h55);
wire detect_ordset_55_1_w     =           (ctrlin[0]==1'b1)                          & detect_ordset_55_0_r;
wire detect_start_78_0_w      = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h78);
wire detect_start_78_1_w      =           (ctrlin[0]==1'b1)                          & detect_start_78_0_r;
wire detect_ordset_4b_0_w     = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h4b);
wire detect_ordset_4b_1_w     =           (ctrlin[0]==1'b1)                          & detect_ordset_4b_0_r;
wire detect_terminate_87_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h87);
wire detect_terminate_87_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_87_0_r;
wire detect_terminate_99_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'h99);
wire detect_terminate_99_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_99_0_r;
wire detect_terminate_aa_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'haa);
wire detect_terminate_aa_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_aa_0_r;
wire detect_terminate_b4_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'hb4);
wire detect_terminate_b4_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_b4_0_r;
wire detect_terminate_cc_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'hcc);
wire detect_terminate_cc_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_cc_0_r;
wire detect_terminate_cc_2_w  =                                                        detect_terminate_cc_1_r;
wire detect_terminate_d2_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'hd2);
wire detect_terminate_d2_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_d2_0_r;
wire detect_terminate_d2_2_w  =                                                        detect_terminate_d2_1_r;
wire detect_terminate_e1_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'he1);
wire detect_terminate_e1_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_e1_0_r;
wire detect_terminate_e1_2_w  =                                                        detect_terminate_e1_1_r;
wire detect_terminate_ff_0_w  = even==0 & (ctrlin[0]==1'b1) & (din[7:0]==8'hff);
wire detect_terminate_ff_1_w  =           (ctrlin[0]==1'b1)                          & detect_terminate_ff_0_r;
wire detect_terminate_ff_2_w  =                                                        detect_terminate_ff_1_r;
wire detect_data_w            =           (ctrlin[0]==1'b0);

wire send_07070707_w           = detect_idle_1e_0_w|detect_idle_1e_1_w|detect_ordset_2d_0_w|detect_start_33_0_w|detect_ordset_4b_1_w|detect_terminate_87_1_w|detect_terminate_99_1_w|detect_terminate_aa_1_w|detect_terminate_b4_1_w;
wire send_070707FD_w           = detect_terminate_cc_2_w|detect_terminate_87_0_w;
wire send_din_w                = detect_start_78_1_w|detect_data_w;
wire send_din_7_0_din_r_31_8_w = detect_terminate_cc_1_w|detect_terminate_d2_1_w|detect_terminate_e1_1_w|detect_terminate_ff_1_w;
wire send_din_31_8_FB_w        = detect_start_33_1_w|detect_start_66_1_w|detect_start_78_0_w;
wire send_din_31_8_9C_w        = detect_ordset_2d_1_w|detect_start_66_0_w|detect_ordset_55_0_w|detect_ordset_55_1_w|detect_ordset_4b_0_w;

always @(posedge clk) if (din_en) detect_idle_1e_0_r       <= detect_idle_1e_0_w     ;
always @(posedge clk) if (din_en) detect_ordset_2d_0_r     <= detect_ordset_2d_0_w   ;
always @(posedge clk) if (din_en) detect_start_33_0_r      <= detect_start_33_0_w    ;  
always @(posedge clk) if (din_en) detect_start_66_0_r      <= detect_start_66_0_w    ;  
always @(posedge clk) if (din_en) detect_ordset_55_0_r     <= detect_ordset_55_0_w   ;
always @(posedge clk) if (din_en) detect_start_78_0_r      <= detect_start_78_0_w    ;  
always @(posedge clk) if (din_en) detect_ordset_4b_0_r     <= detect_ordset_4b_0_w   ;  
always @(posedge clk) if (din_en) detect_terminate_87_0_r  <= detect_terminate_87_0_w;
always @(posedge clk) if (din_en) detect_terminate_99_0_r  <= detect_terminate_99_0_w;
always @(posedge clk) if (din_en) detect_terminate_aa_0_r  <= detect_terminate_aa_0_w;
always @(posedge clk) if (din_en) detect_terminate_b4_0_r  <= detect_terminate_b4_0_w;
always @(posedge clk) if (din_en) detect_terminate_cc_0_r  <= detect_terminate_cc_0_w;
always @(posedge clk) if (din_en) detect_terminate_cc_1_r  <= detect_terminate_cc_1_w;
always @(posedge clk) if (din_en) detect_terminate_d2_0_r  <= detect_terminate_d2_0_w;
always @(posedge clk) if (din_en) detect_terminate_d2_1_r  <= detect_terminate_d2_1_w;
always @(posedge clk) if (din_en) detect_terminate_e1_0_r  <= detect_terminate_e1_0_w;
always @(posedge clk) if (din_en) detect_terminate_e1_1_r  <= detect_terminate_e1_1_w;
always @(posedge clk) if (din_en) detect_terminate_ff_0_r  <= detect_terminate_ff_0_w;
always @(posedge clk) if (din_en) detect_terminate_ff_1_r  <= detect_terminate_ff_1_w;

always @(posedge clk) begin if (din_en) begin din_r <= din; end end 
    
always @(posedge clk) {dout_0r,ctrlout_0r} <= (send_din_7_0_din_r_31_8_w) ? ( {{din[7:0],din_r[31:8]}     ,4'b0000} ) :
                                              (send_070707FD_w          ) ? ( {32'h07_07_07_FD            ,4'b1111} ) :
                                              (detect_terminate_d2_2_w  ) ? ( {{24'h07_07_FD,din_r[15:8]} ,4'b1110} ) :
                                              (detect_terminate_e1_2_w  ) ? ( {{16'h07_FD,din_r[23:8]}    ,4'b1100} ) :
                                              (detect_terminate_ff_2_w  ) ? ( {{8'hFD,din_r[31:8]}        ,4'b1000} ) :
                                              (send_07070707_w          ) ? ( {32'h07_07_07_07            ,4'b1111} ) : 
                                                                            ( {32'h00000000               ,4'b0000} );

always @(posedge clk) {dout_1r,ctrlout_1r} <= (send_din_31_8_FB_w       ) ? ( {{din[31:8],8'hFB}          ,4'b0001} ) : 
                                              (send_din_31_8_9C_w       ) ? ( {{din[31:8],8'h9C}          ,4'b0001} ) : 
                                              (send_din_w               ) ? ( {din                        ,4'b0000} ) : 
                                              (detect_terminate_99_0_w  ) ? ( {{24'h07_07_FD,din[15:8]}   ,4'b1110} ) : 
                                              (detect_terminate_aa_0_w  ) ? ( {{16'h07_FD,din[23:8]}      ,4'b1100} ) : 
                                              (detect_terminate_b4_0_w  ) ? ( {{8'hFD,din[31:8]}          ,4'b1000} ) : 
                                                                            ( {32'h00000000               ,4'b0000} );

always @(posedge clk) dout_en_0r <= !rst & din_en & ( (send_din_7_0_din_r_31_8_w) | 
                                                      (send_070707FD_w          ) |
                                                      (detect_terminate_d2_2_w  ) | 
                                                      (detect_terminate_e1_2_w  ) | 
                                                      (detect_terminate_ff_2_w  ) | 
                                                      (send_07070707_w          )   ); 

always @(posedge clk) dout_en_1r <= !rst & din_en & ( (send_din_31_8_FB_w       ) | 
                                                      (send_din_31_8_9C_w       ) | 
                                                      (send_din_w               ) | 
                                                      (detect_terminate_99_0_w  ) | 
                                                      (detect_terminate_aa_0_w  ) | 
                                                      (detect_terminate_b4_0_w  )   ); 

always @(posedge clk) nerr_ctrl_r  <= (ctrlin[0]!=ctrlin[1]);

assign dout_en = (dout_en_0r | dout_en_1r) & nerr_ctrl_r;
assign dout    = dout_en_0r ? dout_0r    : dout_1r   ;
assign ctrlout = dout_en_0r ? ctrlout_0r : ctrlout_1r;

endmodule
