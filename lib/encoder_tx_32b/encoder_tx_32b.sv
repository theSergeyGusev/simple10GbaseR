module encoder_tx_32b
(
    input wire clk,
    input wire rst,

    input wire [31:0] din,
    input wire [3:0]  ctrlin,
    input wire        din_en,

    output wire [31:0] dout,
    output wire [ 1:0] ctrlout,
    output wire        dout_en,
    output wire        even 
);

reg [31:0] din_0r    = 0;
reg [31:0] din_1r    = 0;
reg [31:0] dout_0r   = 0;
reg [31:0] dout_1r   = 0;
reg [ 1:0] ctrlout_r = 0;
reg        dout_en_0r= 0;
reg        dout_en_1r= 0;
reg        even_r    = 0;
reg        even_out_r= 0;

reg send_idle_1e_r  = 0; 
reg send_start_33_r = 0; 
reg send_start_78_r = 0; 
reg send_data_r     = 0; 
reg send_stop_87_r  = 0; 
reg send_stop_99_r  = 0; 
reg send_stop_aa_r  = 0; 
reg send_stop_b4_r  = 0; 
reg send_stop_cc_r  = 0; 
reg send_stop_d2_r  = 0; 
reg send_stop_e1_r  = 0; 
reg send_stop_ff_r  = 0; 

wire idle_w  = din_en & (ctrlin==4'b1111) & (din[31: 0]==32'h07070707) ;
wire start_w = din_en & (ctrlin==4'b0001) & (din[ 7: 0]==8'hFB)        ;
wire data_w  = din_en & (ctrlin==4'b0000)                              ;
wire stop0_w = din_en & (ctrlin==4'b1111) & (din[31: 0]==32'h070707FD) ;
wire stop1_w = din_en & (ctrlin==4'b1110) & (din[31: 8]==24'h0707FD)   ;
wire stop2_w = din_en & (ctrlin==4'b1100) & (din[31:16]==16'h07FD)     ;
wire stop3_w = din_en & (ctrlin==4'b1000) & (din[31:24]==8'hFD)        ;

reg idle_r  = 0; 
reg start_r = 0; 
reg data_r  = 0; 
reg stop0_r = 0; 
reg stop1_r = 0; 
reg stop2_r = 0; 
reg stop3_r = 0; 

always @(posedge clk) if (din_en) din_0r    <= din;
always @(posedge clk) if (din_en) din_1r    <= din_0r;
always @(posedge clk) if (din_en) even_r    <= !even_r;

always @(posedge clk) if (din_en) idle_r   <= idle_w ; 
always @(posedge clk) if (din_en) start_r  <= start_w;
always @(posedge clk) if (din_en) data_r   <= data_w ; 
always @(posedge clk) if (din_en) stop0_r  <= stop0_w;
always @(posedge clk) if (din_en) stop1_r  <= stop1_w;
always @(posedge clk) if (din_en) stop2_r  <= stop2_w;
always @(posedge clk) if (din_en) stop3_r  <= stop3_w;

wire send_idle_1e_w  = even_r==1 & idle_r ==1 & idle_w ==1;
wire send_start_33_w = even_r==1 & idle_r ==1 & start_w==1;
wire send_start_78_w = even_r==1 & start_r==1 & data_w ==1;
wire send_data_w     = even_r==1 & data_r ==1 & data_w ==1;
wire send_stop_87_w  = even_r==1 & stop0_r==1 & idle_w ==1;
wire send_stop_99_w  = even_r==1 & stop1_r==1 & idle_w ==1;
wire send_stop_aa_w  = even_r==1 & stop2_r==1 & idle_w ==1;
wire send_stop_b4_w  = even_r==1 & stop3_r==1 & idle_w ==1;
wire send_stop_cc_w  = even_r==1 & stop0_w==1 & data_r ==1;
wire send_stop_d2_w  = even_r==1 & stop1_w==1 & data_r ==1;
wire send_stop_e1_w  = even_r==1 & stop2_w==1 & data_r ==1;
wire send_stop_ff_w  = even_r==1 & stop3_w==1 & data_r ==1;

wire send_00000000_w = send_stop_87_r | send_stop_99_r | send_stop_aa_r | send_stop_b4_r | send_idle_1e_r;
wire send_dinr_w = send_start_78_r | send_data_w | send_data_r;

always @(posedge clk) send_idle_1e_r  <=  send_idle_1e_w  ;  
always @(posedge clk) send_start_33_r <=  send_start_33_w ;  
always @(posedge clk) send_start_78_r <=  send_start_78_w ;  
always @(posedge clk) send_data_r     <=  send_data_w     ;  
always @(posedge clk) send_stop_87_r  <=  send_stop_87_w  ;  
always @(posedge clk) send_stop_99_r  <=  send_stop_99_w  ;  
always @(posedge clk) send_stop_aa_r  <=  send_stop_aa_w  ;  
always @(posedge clk) send_stop_b4_r  <=  send_stop_b4_w  ;  
always @(posedge clk) send_stop_cc_r  <=  send_stop_cc_w  ;  
always @(posedge clk) send_stop_d2_r  <=  send_stop_d2_w  ;  
always @(posedge clk) send_stop_e1_r  <=  send_stop_e1_w  ;  
always @(posedge clk) send_stop_ff_r  <=  send_stop_ff_w  ;  

always @(posedge clk) dout_0r <= (send_start_33_w) ? (                 32'h00000033) : (send_start_33_r) ? (                  {din_0r[31:8],8'd0}) : 
                                 (send_start_78_w) ? (         {din_0r[31:8],8'h78}) : (send_dinr_w    ) ? (                               din_0r) : 
                                 (send_stop_87_w ) ? (                 32'h00000087) : (send_00000000_w) ? (                         32'h00000000) : 
                                 (send_stop_99_w ) ? ( {16'h0000,din_0r[7:0],8'h99}) : 
                                 (send_stop_aa_w ) ? (   {8'h00,din_0r[15:0],8'hAA}) : 
                                 (send_stop_b4_w ) ? (         {din_0r[23:0],8'hB4}) : 
                                                                                                           (                         32'h00000000) ;

always @(posedge clk) dout_1r <= (send_stop_cc_w ) ? (         {din_0r[23:0],8'hCC}) : (send_stop_cc_r ) ? ({24'h000000,           din_1r[31:24]}) : 
                                 (send_stop_d2_w ) ? (         {din_0r[23:0],8'hD2}) : (send_stop_d2_r ) ? ({16'h0000,din_0r[ 7:0],din_1r[31:24]}) : 
                                 (send_stop_e1_w ) ? (         {din_0r[23:0],8'hE1}) : (send_stop_e1_r ) ? ({8'h00,   din_0r[15:0],din_1r[31:24]}) : 
                                 (send_stop_ff_w ) ? (         {din_0r[23:0],8'hFF}) : (send_stop_ff_r ) ? ({         din_0r[23:0],din_1r[31:24]}) : 
                                 (send_idle_1e_w ) ? (                 32'h0000001E) :  
                                                                                                           (                         32'h00000000) ;
always @(posedge clk) dout_en_0r <= (send_start_33_w) | (send_start_33_r) |
                                    (send_start_78_w) | (send_dinr_w    ) |
                                    (send_stop_87_w ) | (send_00000000_w) |
                                    (send_stop_99_w ) | 
                                    (send_stop_aa_w ) | 
                                    (send_stop_b4_w )                     ;

always @(posedge clk) dout_en_1r <= (send_stop_cc_w ) | (send_stop_cc_r ) | 
                                    (send_stop_d2_w ) | (send_stop_d2_r ) | 
                                    (send_stop_e1_w ) | (send_stop_e1_r ) | 
                                    (send_stop_ff_w ) | (send_stop_ff_r ) | 
                                    (send_idle_1e_w )    
                                                                          ;

wire ctrl_word_w = send_start_33_w | send_start_33_r | 
                   send_start_78_w | send_start_78_r | 
                   send_stop_87_w  | send_stop_87_r  | 
                   send_stop_99_w  | send_stop_99_r  | 
                   send_stop_aa_w  | send_stop_aa_r  | 
                   send_stop_b4_w  | send_stop_b4_r  | 
                   send_stop_cc_w  | send_stop_cc_r  | 
                   send_stop_d2_w  | send_stop_d2_r  | 
                   send_stop_e1_w  | send_stop_e1_r  | 
                   send_stop_ff_w  | send_stop_ff_r  | 
                   send_idle_1e_w  | send_idle_1e_r  ; 

wire data_word_w = send_data_w | send_data_r;

wire even_0_w = send_start_33_w | 
                send_start_78_w | 
                send_stop_87_w  | 
                send_stop_99_w  | 
                send_stop_aa_w  | 
                send_stop_b4_w  | 
                send_stop_cc_w  | 
                send_stop_d2_w  | 
                send_stop_e1_w  | 
                send_stop_ff_w  | 
                send_idle_1e_w  |
                send_data_w     ; 

wire even_1_w = send_start_33_r | 
                send_start_78_r | 
                send_stop_87_r  | 
                send_stop_99_r  | 
                send_stop_aa_r  | 
                send_stop_b4_r  | 
                send_stop_cc_r  | 
                send_stop_d2_r  | 
                send_stop_e1_r  | 
                send_stop_ff_r  | 
                send_idle_1e_r  |
                send_data_r     ; 

always @(posedge clk) ctrlout_r  <= ctrl_word_w ? (2'b01) : (data_word_w) ? (2'b10) : (2'b00); 
always @(posedge clk) even_out_r <= even_0_w ? (0) : (even_1_w) ? (1) : (0); 

assign dout    = dout_en_0r ? dout_0r : dout_en_1r ? dout_1r : '0; 
assign ctrlout = ctrlout_r ;
assign dout_en = dout_en_0r|dout_en_1r;
assign even    = even_out_r;

endmodule
