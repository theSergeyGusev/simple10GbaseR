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

reg find_idle_1e_0_r      = 0; 
reg find_ordset_2d_0_r    = 0; 
reg find_start_33_0_r     = 0; 
reg find_start_66_0_r     = 0; 
reg find_ordset_55_0_r    = 0; 
reg find_start_78_0_r     = 0; 
reg find_ordset_4b_0_r    = 0; 
reg find_terminate_87_0_r = 0; 
reg find_terminate_99_0_r = 0; 
reg find_terminate_aa_0_r = 0; 
reg find_terminate_b4_0_r = 0; 
reg find_terminate_cc_0_r = 0; 
reg find_terminate_cc_1_r = 0; 
reg find_terminate_d2_0_r = 0; 
reg find_terminate_d2_1_r = 0; 
reg find_terminate_e1_0_r = 0; 
reg find_terminate_e1_1_r = 0; 
reg find_terminate_ff_0_r = 0; 
reg find_terminate_ff_1_r = 0; 

wire find_idle_1e_0_w       = even==0 & (ctrlin==2'b01) & (din==32'h00_00_00_1E);
wire find_idle_1e_1_w       = even==1 & (ctrlin==2'b01) & (din==32'h00_00_00_00)    & find_idle_1e_0_r;
wire find_ordset_2d_0_w     = even==0 & (ctrlin==2'b01) & (din==32'h00_00_00_2D);    
wire find_ordset_2d_1_w     = even==1 & (ctrlin==2'b01)                             & find_ordset_2d_0_r; 
wire find_start_33_0_w      = even==0 & (ctrlin==2'b01) & (din==32'h00_00_00_33);   
wire find_start_33_1_w      = even==1 & (ctrlin==2'b01)                             & find_start_33_0_r;
wire find_start_66_0_w      = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h66);
wire find_start_66_1_w      = even==1 & (ctrlin==2'b01)                             & find_start_66_0_r;
wire find_ordset_55_0_w     = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h55);
wire find_ordset_55_1_w     = even==1 & (ctrlin==2'b01)                             & find_ordset_55_0_r;
wire find_start_78_0_w      = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h78);
wire find_start_78_1_w      = even==1 & (ctrlin==2'b01)                             & find_start_78_0_r;
wire find_ordset_4b_0_w     = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h4b);
wire find_ordset_4b_1_w     = even==1 & (ctrlin==2'b01) & (din[31:8]==24'h00_00_00) & find_ordset_4b_0_r;
wire find_terminate_87_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h87)&(din[31:16]==16'h00_00);
wire find_terminate_87_1_w  = even==1 & (ctrlin==2'b01) & (din==32'h00_00_00_00)    & find_terminate_87_0_r;
wire find_terminate_99_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'h99)&(din[31:24]==8'h00);
wire find_terminate_99_1_w  = even==1 & (ctrlin==2'b01) & (din==32'h00_00_00_00)    & find_terminate_99_0_r;
wire find_terminate_aa_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'haa);
wire find_terminate_aa_1_w  = even==1 & (ctrlin==2'b01) & (din==32'h00_00_00_00)    & find_terminate_aa_0_r;
wire find_terminate_b4_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'hb4);
wire find_terminate_b4_1_w  = even==1 & (ctrlin==2'b01) & (din[31:8]==24'h00_00_00) & find_terminate_b4_0_r;
wire find_terminate_cc_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'hcc);
wire find_terminate_cc_1_w  = even==1 & (ctrlin==2'b01) & (din[31:16]==16'h00_00)   & find_terminate_cc_0_r;
wire find_terminate_cc_2_w  =                                                         find_terminate_cc_1_r;
wire find_terminate_d2_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'hd2);
wire find_terminate_d2_1_w  = even==1 & (ctrlin==2'b01) & (din[31:24]==8'h00)       & find_terminate_d2_0_r;
wire find_terminate_d2_2_w  =                                                         find_terminate_d2_1_r;
wire find_terminate_e1_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'he1);
wire find_terminate_e1_1_w  = even==1 & (ctrlin==2'b01)                             & find_terminate_e1_0_r;
wire find_terminate_e1_2_w  =                                                         find_terminate_e1_1_r;
wire find_terminate_ff_0_w  = even==0 & (ctrlin==2'b01) & (din[7:0]==8'hff);
wire find_terminate_ff_1_w  = even==1 & (ctrlin==2'b01)                             & find_terminate_ff_0_r;
wire find_terminate_ff_2_w  =                                                         find_terminate_ff_1_r;
wire find_data_w            =           (ctrlin==2'b10);

wire tr_07070707_w           = find_idle_1e_0_w|find_idle_1e_1_w|find_ordset_2d_0_w|find_start_33_0_w|find_ordset_4b_1_w|find_terminate_87_1_w|find_terminate_99_1_w|find_terminate_aa_1_w|find_terminate_b4_1_w;
wire tr_070707FD_w           = find_terminate_cc_2_w|find_terminate_87_0_w;
wire tr_din_w                = find_start_78_1_w|find_data_w;
wire tr_din_7_0_din_r_31_8_w = find_terminate_cc_1_w|find_terminate_d2_1_w|find_terminate_e1_1_w|find_terminate_ff_1_w;
wire tr_din_31_8_FB_w        = find_start_33_1_w|find_start_66_1_w|find_start_78_0_w;
wire tr_din_31_8_9C_w        = find_ordset_2d_1_w|find_start_66_0_w|find_ordset_55_0_w|find_ordset_55_1_w|find_ordset_4b_0_w;

always @(posedge clk) if (din_en) find_idle_1e_0_r       <= find_idle_1e_0_w     ;
always @(posedge clk) if (din_en) find_ordset_2d_0_r     <= find_ordset_2d_0_w   ;
always @(posedge clk) if (din_en) find_start_33_0_r      <= find_start_33_0_w    ;  
always @(posedge clk) if (din_en) find_start_66_0_r      <= find_start_66_0_w    ;  
always @(posedge clk) if (din_en) find_ordset_55_0_r     <= find_ordset_55_0_w   ;
always @(posedge clk) if (din_en) find_start_78_0_r      <= find_start_78_0_w    ;  
always @(posedge clk) if (din_en) find_ordset_4b_0_r     <= find_ordset_4b_0_w   ;  
always @(posedge clk) if (din_en) find_terminate_87_0_r  <= find_terminate_87_0_w;
always @(posedge clk) if (din_en) find_terminate_99_0_r  <= find_terminate_99_0_w;
always @(posedge clk) if (din_en) find_terminate_aa_0_r  <= find_terminate_aa_0_w;
always @(posedge clk) if (din_en) find_terminate_b4_0_r  <= find_terminate_b4_0_w;
always @(posedge clk) if (din_en) find_terminate_cc_0_r  <= find_terminate_cc_0_w;
always @(posedge clk) if (din_en) find_terminate_cc_1_r  <= find_terminate_cc_1_w;
always @(posedge clk) if (din_en) find_terminate_d2_0_r  <= find_terminate_d2_0_w;
always @(posedge clk) if (din_en) find_terminate_d2_1_r  <= find_terminate_d2_1_w;
always @(posedge clk) if (din_en) find_terminate_e1_0_r  <= find_terminate_e1_0_w;
always @(posedge clk) if (din_en) find_terminate_e1_1_r  <= find_terminate_e1_1_w;
always @(posedge clk) if (din_en) find_terminate_ff_0_r  <= find_terminate_ff_0_w;
always @(posedge clk) if (din_en) find_terminate_ff_1_r  <= find_terminate_ff_1_w;

always @(posedge clk) begin if (din_en) begin din_r <= din; end end 
    
always @(posedge clk) {dout_0r,ctrlout_0r} <= (tr_din_7_0_din_r_31_8_w) ? ( {{din[7:0],din_r[31:8]}     ,4'b0000} ) :
                                              (tr_070707FD_w          ) ? ( {32'h07_07_07_FD            ,4'b1111} ) :
                                              (find_terminate_d2_2_w  ) ? ( {{24'h07_07_FD,din_r[15:8]} ,4'b1110} ) :
                                              (find_terminate_e1_2_w  ) ? ( {{16'h07_FD,din_r[23:8]}    ,4'b1100} ) :
                                              (find_terminate_ff_2_w  ) ? ( {{8'hFD,din_r[31:8]}        ,4'b1000} ) :
                                              (tr_07070707_w          ) ? ( {32'h07_07_07_07            ,4'b1111} ) : 
                                                                          ( {32'h00000000               ,4'b0000} );

always @(posedge clk) {dout_1r,ctrlout_1r} <= (tr_din_31_8_FB_w       ) ? ( {{din[31:8],8'hFB}          ,4'b0001} ) : 
                                              (tr_din_31_8_9C_w       ) ? ( {{din[31:8],8'h9C}          ,4'b0001} ) : 
                                              (tr_din_w               ) ? ( {din                        ,4'b0000} ) : 
                                              (find_terminate_99_0_w  ) ? ( {{24'h07_07_FD,din[15:8]}   ,4'b1110} ) : 
                                              (find_terminate_aa_0_w  ) ? ( {{16'h07_FD,din[23:8]}      ,4'b1100} ) : 
                                              (find_terminate_b4_0_w  ) ? ( {{8'hFD,din[31:8]}          ,4'b1000} ) : 
                                                                          ( {32'h00000000               ,4'b0000} );

always @(posedge clk) dout_en_0r <= !rst & din_en & ( (tr_din_7_0_din_r_31_8_w) | 
                                                      (tr_070707FD_w          ) |
                                                      (find_terminate_d2_2_w  ) | 
                                                      (find_terminate_e1_2_w  ) | 
                                                      (find_terminate_ff_2_w  ) | 
                                                      (tr_07070707_w          ) ); 

always @(posedge clk) dout_en_1r <= !rst & din_en & ( (tr_din_31_8_FB_w       ) | 
                                                      (tr_din_31_8_9C_w       ) | 
                                                      (tr_din_w               ) | 
                                                      (find_terminate_99_0_w  ) | 
                                                      (find_terminate_aa_0_w  ) | 
                                                      (find_terminate_b4_0_w  ) ); 

always @(posedge clk) nerr_ctrl_r  <= (ctrlin[0]!=ctrlin[1]);

assign dout_en = (dout_en_0r | dout_en_1r) & nerr_ctrl_r;
assign dout    = dout_en_0r ? dout_0r    : dout_1r   ;
assign ctrlout = dout_en_0r ? ctrlout_0r : ctrlout_1r;

endmodule
