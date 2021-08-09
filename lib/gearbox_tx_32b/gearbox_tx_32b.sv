module gearbox_tx_32b
(
    input wire clk,
    input wire rst,

    input wire [31:0] din,
    input wire [1:0]  ctrl,
    input wire        din_en,
    input wire        even,

    output wire [31:0] dout
);

wire [31:0] dout_w    ;
reg  [5:0]  cnt_r  = 0;
reg  [31:0] dout_r = 0;
reg  [31:0] din_r  = 0;

always @(posedge clk) begin if (din_en) begin cnt_r <= cnt_r + 1; end else begin cnt_r <= 0; end end
always @(posedge clk) if (din_en) din_r <= din; 

assign dout_w  = (cnt_r== 0) ? ({din[29:0],ctrl             }) : (cnt_r== 1) ? ({din[29:0],din_r[31:30]}) :  
                 (cnt_r== 2) ? ({din[27:0],ctrl,din_r[31:30]}) : (cnt_r== 3) ? ({din[27:0],din_r[31:28]}) :  
                 (cnt_r== 4) ? ({din[25:0],ctrl,din_r[31:28]}) : (cnt_r== 5) ? ({din[25:0],din_r[31:26]}) :  
                 (cnt_r== 6) ? ({din[23:0],ctrl,din_r[31:26]}) : (cnt_r== 7) ? ({din[23:0],din_r[31:24]}) :  
                 (cnt_r== 8) ? ({din[21:0],ctrl,din_r[31:24]}) : (cnt_r== 9) ? ({din[21:0],din_r[31:22]}) :  
                 (cnt_r==10) ? ({din[19:0],ctrl,din_r[31:22]}) : (cnt_r==11) ? ({din[19:0],din_r[31:20]}) :  
                 (cnt_r==12) ? ({din[17:0],ctrl,din_r[31:20]}) : (cnt_r==13) ? ({din[17:0],din_r[31:18]}) :  
                 (cnt_r==14) ? ({din[15:0],ctrl,din_r[31:18]}) : (cnt_r==15) ? ({din[15:0],din_r[31:16]}) :  
                 (cnt_r==16) ? ({din[13:0],ctrl,din_r[31:16]}) : (cnt_r==17) ? ({din[13:0],din_r[31:14]}) :  
                 (cnt_r==18) ? ({din[11:0],ctrl,din_r[31:14]}) : (cnt_r==19) ? ({din[11:0],din_r[31:12]}) :  
                 (cnt_r==20) ? ({din[09:0],ctrl,din_r[31:12]}) : (cnt_r==21) ? ({din[09:0],din_r[31:10]}) :  
                 (cnt_r==22) ? ({din[07:0],ctrl,din_r[31:10]}) : (cnt_r==23) ? ({din[07:0],din_r[31:08]}) :  
                 (cnt_r==24) ? ({din[05:0],ctrl,din_r[31:08]}) : (cnt_r==25) ? ({din[05:0],din_r[31:06]}) :  
                 (cnt_r==26) ? ({din[03:0],ctrl,din_r[31:06]}) : (cnt_r==27) ? ({din[03:0],din_r[31:04]}) :  
                 (cnt_r==28) ? ({din[01:0],ctrl,din_r[31:04]}) : (cnt_r==29) ? ({din[01:0],din_r[31:02]}) :  
                 (cnt_r==30) ? ({          ctrl,din_r[31:02]}) : (cnt_r==31) ? ({          din_r[31:00]}) :  
                 (cnt_r==32) ? ({               din_r[31:00]})                                            : ('0); 

//always @(posedge clk) dout_r <= dout_w;

assign dout = dout_w;

endmodule
