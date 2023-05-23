import gtype::xgmii32_t;
import gtype::xgmii64_t;

module xgmii_retransmit_32b64b_fifo
(
    input wire clk_rx,
    input wire clk_tx,
    input  xgmii32_t rx,
    output xgmii64_t tx
);

wire [79:0] fifo_xgmii_retransmit_64b64b_data_w    ;
wire        fifo_xgmii_retransmit_64b64b_rdclk_w   ;
wire        fifo_xgmii_retransmit_64b64b_rdreq_w   ;
wire        fifo_xgmii_retransmit_64b64b_wrclk_w   ;
wire        fifo_xgmii_retransmit_64b64b_wrreq_w   ;
wire [79:0] fifo_xgmii_retransmit_64b64b_q_w       ;
wire        fifo_xgmii_retransmit_64b64b_rdempty_w ;
wire        fifo_xgmii_retransmit_64b64b_wrfull_w  ;
wire [9:0]  fifo_xgmii_retransmit_64b64b_rdusedw_w ;

wire        start_w = rx.ena &  (rx.ctrl==4'b0001 & rx.data[7:0]==8'hFB);

wire        state_w = rx.ena & ((rx.ctrl==4'b0001 & rx.data[7:0]==8'hFB) | //start
                                (rx.ctrl==4'b0000                      ) | //data 
                                (rx.ctrl==4'b1111 & rx.data[7:0]==8'hFD) | //stop
                                (rx.ctrl==4'b1110                      ) | //stop
                                (rx.ctrl==4'b1100                      ) | //stop
                                (rx.ctrl==4'b1000                      ) );//stop

xgmii32_t rx_r;
reg       cnt_32_r = 0;
reg       state_0r = 0;
reg       state_1r = 0;

always @(posedge clk_rx) if (rx.ena) rx_r <= rx;
always @(posedge clk_rx) if (rx.ena) state_0r  <= state_w;
always @(posedge clk_rx) if (rx.ena) state_1r  <= state_0r;

always @(posedge clk_rx) begin
    if      (start_w) begin cnt_32_r <= 1;          end
    else if (rx.ena)  begin cnt_32_r <= !cnt_32_r;  end
end

////////////////////////////////////////////////////////////////////////////////
assign fifo_xgmii_retransmit_64b64b_wrclk_w  = clk_rx; 
assign fifo_xgmii_retransmit_64b64b_wrreq_w  = cnt_32_r & !start_w & rx.ena & (state_w | state_0r | state_1r);
assign fifo_xgmii_retransmit_64b64b_data_w   = {8'd0,rx.ctrl,rx_r.ctrl,rx.data,rx_r.data};
assign fifo_xgmii_retransmit_64b64b_rdclk_w  = clk_tx;
assign fifo_xgmii_retransmit_64b64b_rdreq_w  = !fifo_xgmii_retransmit_64b64b_rdempty_w;

fifo_xgmii_retransmit_64b64b fifo_xgmii_retransmit_64b64b_u 
(
    .wrclk   (fifo_xgmii_retransmit_64b64b_wrclk_w  ),
    .wrreq   (fifo_xgmii_retransmit_64b64b_wrreq_w  ),
    .data    (fifo_xgmii_retransmit_64b64b_data_w   ),
    .wrfull  (fifo_xgmii_retransmit_64b64b_wrfull_w ),
    .rdclk   (fifo_xgmii_retransmit_64b64b_rdclk_w  ),
    .rdreq   (fifo_xgmii_retransmit_64b64b_rdreq_w  ),
    .q       (fifo_xgmii_retransmit_64b64b_q_w      ),
    .rdempty (fifo_xgmii_retransmit_64b64b_rdempty_w),
    .rdusedw (fifo_xgmii_retransmit_64b64b_rdusedw_w)
);
////////////////////////////////////////////////////////////////////////////////

assign tx.data = fifo_xgmii_retransmit_64b64b_q_w[63:0];
assign tx.ctrl = fifo_xgmii_retransmit_64b64b_q_w[71:64];
assign tx.ena  = fifo_xgmii_retransmit_64b64b_rdreq_w;

endmodule
