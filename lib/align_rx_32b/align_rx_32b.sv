module align_rx_32b
(
    input wire clk,
    input wire rst,
    input wire [31:0] din,

    output wire [31:0] dout,
    output wire [1:0]  ctrl,
    output wire        dout_en,
    output wire        even
);

reg [5:0]  cnt_r        = 0;
reg [5:0]  cnt_1r       = 0;
reg [1:0]  ctrl_r       = 0;
reg [31:0] data_r       = 0;
reg [31:0] din_r        = 0;
reg        dout_en_r    = 0;
reg        dout_en_zero_r=0;
reg        err_ctrl_r   = 0;
reg        sync_r       = 0;
reg        sleep_r      = 0;
reg        sleep_cnt_r  = 0;
reg        sleep_even_r = 0;

wire [31:0] dout_w;
wire        even_w;
wire        cnt_w;
wire [1:0]  ctrl_w;

reg [W_SYNC-1:0] cnt_sync_r = 0;
reg [5:0]        add_cnt_r = 0;

always @(posedge clk) if (cnt_r!=32) begin cnt_r <= cnt_r + 1; end else begin cnt_r <= 0; end
always @(posedge clk) din_r  <= din;
always @(posedge clk) dout_en_zero_r <= (cnt_r==31);
always @(posedge clk) dout_en_r <= (rst==0) & (!dout_en_zero_r) & (sync_r==1);

assign ctrl_w  = (cnt_r== 0) ? (din[ 1: 0]) : 
                 (cnt_r== 2) ? (din[ 3: 2]) : 
                 (cnt_r== 4) ? (din[ 5: 4]) : 
                 (cnt_r== 6) ? (din[ 7: 6]) : 
                 (cnt_r== 8) ? (din[ 9: 8]) : 
                 (cnt_r==10) ? (din[11:10]) : 
                 (cnt_r==12) ? (din[13:12]) : 
                 (cnt_r==14) ? (din[15:14]) : 
                 (cnt_r==16) ? (din[17:16]) : 
                 (cnt_r==18) ? (din[19:18]) : 
                 (cnt_r==20) ? (din[21:20]) : 
                 (cnt_r==22) ? (din[23:22]) : 
                 (cnt_r==24) ? (din[25:24]) : 
                 (cnt_r==26) ? (din[27:26]) : 
                 (cnt_r==28) ? (din[29:28]) : 
                 (cnt_r==30) ? (din[31:30]) : (ctrl_r); 

always @(posedge clk) ctrl_r <= ctrl_w;

assign dout_w =(cnt_r== 1 | cnt_r== 2) ? ({din[ 1:0],din_r[31: 2]}) :       
               (cnt_r== 3 | cnt_r== 4) ? ({din[ 3:0],din_r[31: 4]}) :      
               (cnt_r== 5 | cnt_r== 6) ? ({din[ 5:0],din_r[31: 6]}) :      
               (cnt_r== 7 | cnt_r== 8) ? ({din[ 7:0],din_r[31: 8]}) :      
               (cnt_r== 9 | cnt_r==10) ? ({din[ 9:0],din_r[31:10]}) :      
               (cnt_r==11 | cnt_r==12) ? ({din[11:0],din_r[31:12]}) :      
               (cnt_r==13 | cnt_r==14) ? ({din[13:0],din_r[31:14]}) :      
               (cnt_r==15 | cnt_r==16) ? ({din[15:0],din_r[31:16]}) :      
               (cnt_r==17 | cnt_r==18) ? ({din[17:0],din_r[31:18]}) :      
               (cnt_r==19 | cnt_r==20) ? ({din[19:0],din_r[31:20]}) :      
               (cnt_r==21 | cnt_r==22) ? ({din[21:0],din_r[31:22]}) :      
               (cnt_r==23 | cnt_r==24) ? ({din[23:0],din_r[31:24]}) :      
               (cnt_r==25 | cnt_r==26) ? ({din[25:0],din_r[31:26]}) :      
               (cnt_r==27 | cnt_r==28) ? ({din[27:0],din_r[31:28]}) :      
               (cnt_r==29 | cnt_r==30) ? ({din[29:0],din_r[31:30]}) :      
               (cnt_r==31 | cnt_r==32) ? ( din[31:0]              ) : (0); 

assign even_w =!cnt_r[0];       

assign dout = dout_w;
assign even  = even_w;
assign ctrl = ctrl_w;
assign dout_en = dout_en_r;

endmodule
