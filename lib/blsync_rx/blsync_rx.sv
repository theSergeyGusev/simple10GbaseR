module blsync_rx
(
    input wire clk,
    input wire rst,

    input  wire [1:0] header,
    input  wire       header_ena,
    output wire       block_lock,
    output wire       slp
);

reg       block_lock_r         = 0;
reg       slip_r               = 0;
reg [7:0] slip_delay_r         = 0;
reg [5:0] sh_cnt_r             = 0;
reg [4:0] sh_invalid_cnt_r     = 0;
reg       header_ena_valid_r   = 0;
reg       header_ena_invalid_r = 0;

wire      header_ena_valid_w   = (slip_delay_r==0) & header_ena & (header[0]!=header[1]);
wire      header_ena_invalid_w = (slip_delay_r==0) & header_ena & (header[0]==header[1]);
wire      good_64_w            = header_ena_valid_r & sh_cnt_r==63 & sh_invalid_cnt_r==0;
wire      slip_w               = header_ena_invalid_r & (sh_invalid_cnt_r==15 | !block_lock_r);
wire      reset_cnt_w          = good_64_w | slip_w | (header_ena_valid_r & sh_cnt_r==63 & sh_invalid_cnt_r!=0) | (header_ena_invalid_r & sh_cnt_r==63 & sh_invalid_cnt_r!=15 & block_lock_r) ;

always @(posedge clk) slip_delay_r         <= {slip_delay_r[6:0],slip_w};
always @(posedge clk) header_ena_valid_r   <= header_ena_valid_w  ;
always @(posedge clk) header_ena_invalid_r <= header_ena_invalid_w;

always @(posedge clk) begin
    if      (rst                                      ) begin sh_cnt_r <= 0; end
    else if (reset_cnt_w                              ) begin sh_cnt_r <= 0; end
    else if (header_ena_valid_r | header_ena_invalid_r) begin sh_cnt_r <= sh_cnt_r + 1; end
end

always @(posedge clk) begin
    if      (rst                 ) begin sh_invalid_cnt_r <= 0; end
    else if (reset_cnt_w         ) begin sh_invalid_cnt_r <= 0; end
    else if (header_ena_invalid_r) begin sh_invalid_cnt_r <= sh_invalid_cnt_r + 1; end
end

always @(posedge clk) begin
    if      (rst      ) begin block_lock_r <= 0; end
    else if (good_64_w) begin block_lock_r <= 1; end
    else if (slip_w   ) begin block_lock_r <= 0; end
end

always @(posedge clk) begin
    if      (rst)    begin slip_r <= 0; end
    else if (slip_w) begin slip_r <= 1; end
    else             begin slip_r <= 0; end
end

assign slp = slip_r;
assign block_lock = block_lock_r;

endmodule
