import gtype::xgmii32_t;

module xgmii_retransmit_32b32b_fifo
(
    input wire clk_rx,
    input xgmii32_t rx,

    input wire clk_tx,
    output xgmii32_t tx
);

wire [39:0] fifo_xgmii_retransmit_32b32b_data_w    ;
wire        fifo_xgmii_retransmit_32b32b_rdclk_w   ;
wire        fifo_xgmii_retransmit_32b32b_rdreq_w   ;
wire        fifo_xgmii_retransmit_32b32b_wrclk_w   ;
wire        fifo_xgmii_retransmit_32b32b_wrreq_w   ;
wire [39:0] fifo_xgmii_retransmit_32b32b_q_w       ;
wire        fifo_xgmii_retransmit_32b32b_rdempty_w ;
wire        fifo_xgmii_retransmit_32b32b_wrfull_w  ;
wire [9:0]  fifo_xgmii_retransmit_32b32b_rdusedw_w ;
wire        fifo_xgmii_retransmit_32b32b_nprogempty_w;
reg         fifo_xgmii_retransmit_32b32b_nprogempty_r;

reg  [1:0] stop_pos_in_r;
wire [1:0] stop_pos_out_w;
reg  [1:0] dic_r = 0;
reg  [1:0] dic_d = 0;

xgmii32_t rx_r;
xgmii32_t tx_r;
reg wr_r = 0;
reg rd_r = 0;
reg [5:0] cnt_r = 0;
reg stop_in_r = 0;
reg stop_out_0r = 0;
reg stop_out_1r = 0;
reg stop_out_2r = 0;
reg rd_en_r = 0;

always @(posedge clk_rx) rx_r      <= rx;
always @(posedge clk_rx) wr_r      <= rx.ena & ((rx.ctrl==4'b0001 & rx.data[7:0]==8'hFB) | //start
                                                (rx.ctrl==4'b0000                      ) | //data 
                                                (rx.ctrl==4'b1111 & rx.data[7:0]==8'hFD) | //stop
                                                (rx.ctrl==4'b1110                      ) | //stop
                                                (rx.ctrl==4'b1100                      ) | //stop
                                                (rx.ctrl==4'b1000                      )   //stop
                                                ); 
always @(posedge clk_rx) stop_in_r <= (rx.ctrl==4'b1111)|(rx.ctrl==4'b1110)|(rx.ctrl==4'b1100)|(rx.ctrl==4'b1000); 

always @(posedge clk_rx) stop_pos_in_r <=  (rx.ctrl==4'b1110) ? (1) : 
                                           (rx.ctrl==4'b1100) ? (2) :
                                           (rx.ctrl==4'b1000) ? (3) : (0);
////////////////////////////////////////////////////////////////////////////////
assign fifo_xgmii_retransmit_32b32b_wrclk_w = clk_rx; 
assign fifo_xgmii_retransmit_32b32b_wrreq_w = wr_r; 
assign fifo_xgmii_retransmit_32b32b_data_w  = {1'b0,stop_pos_in_r,stop_in_r,rx_r.ctrl,rx_r.data}; 
assign fifo_xgmii_retransmit_32b32b_rdclk_w = clk_tx; 
assign fifo_xgmii_retransmit_32b32b_rdreq_w = !fifo_xgmii_retransmit_32b32b_rdempty_w & rd_en_r & (cnt_r!=32) & !(stop_out_0r|stop_out_1r|stop_out_2r); 

fifo_xgmii_retransmit_32b32b fifo_xgmii_retransmit_32b32b_u 
(
    .wrclk   (fifo_xgmii_retransmit_32b32b_wrclk_w  ),
    .wrreq   (fifo_xgmii_retransmit_32b32b_wrreq_w  ),
    .data    (fifo_xgmii_retransmit_32b32b_data_w   ),
    .wrfull  (fifo_xgmii_retransmit_32b32b_wrfull_w ),
    .rdclk   (fifo_xgmii_retransmit_32b32b_rdclk_w  ),
    .rdreq   (fifo_xgmii_retransmit_32b32b_rdreq_w  ),
    .q       (fifo_xgmii_retransmit_32b32b_q_w      ),
    .rdempty (fifo_xgmii_retransmit_32b32b_rdempty_w),
    .rdusedw (fifo_xgmii_retransmit_32b32b_rdusedw_w)

);

assign fifo_xgmii_retransmit_32b32b_nprogempty_w = (fifo_xgmii_retransmit_32b32b_rdusedw_w > 8);
always @(posedge clk_tx) fifo_xgmii_retransmit_32b32b_nprogempty_r <= fifo_xgmii_retransmit_32b32b_nprogempty_w;

assign stop_pos_out_w = fifo_xgmii_retransmit_32b32b_q_w[38:37];
////////////////////////////////////////////////////////////////////////////////

always @(posedge clk_tx) begin 
    if (fifo_xgmii_retransmit_32b32b_rdreq_w & fifo_xgmii_retransmit_32b32b_q_w[36]) begin
        dic_r <= dic_r + stop_pos_out_w;
        dic_d <= dic_r;
    end
    else begin
        if (cnt_r!=32 & stop_out_1r & (dic_r<dic_d)) begin
            stop_out_2r <= 1;
        end
        else begin
            stop_out_2r <= 0;
        end
    end
end

always @(posedge clk_tx) stop_out_0r <= !fifo_xgmii_retransmit_32b32b_rdempty_w & (cnt_r!=32) & fifo_xgmii_retransmit_32b32b_q_w[36];
always @(posedge clk_tx) if (cnt_r!=32) stop_out_1r <= stop_out_0r;
always @(posedge clk_tx) begin 
    if (cnt_r!=32) begin 
        if (fifo_xgmii_retransmit_32b32b_q_w[36]) begin
            rd_en_r <= 0;
        end
        else if (fifo_xgmii_retransmit_32b32b_nprogempty_r) begin
            rd_en_r <= 1;
        end
    end 
end 

always @(posedge clk_tx) cnt_r <= (cnt_r==32) ? (0) : (cnt_r + 1);

always @(posedge clk_tx) tx_r.data  <= fifo_xgmii_retransmit_32b32b_rdreq_w ? (fifo_xgmii_retransmit_32b32b_q_w[31: 0]) : (32'h07070707);
always @(posedge clk_tx) tx_r.ctrl  <= fifo_xgmii_retransmit_32b32b_rdreq_w ? (fifo_xgmii_retransmit_32b32b_q_w[35:32]) : (4'b1111);
always @(posedge clk_tx) tx_r.ena   <= (cnt_r!=32);

assign tx = tx_r;

endmodule
