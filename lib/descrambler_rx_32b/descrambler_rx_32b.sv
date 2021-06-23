module descrambler_rx_32b
(
    input wire        clk,
    input wire [31:0] din,
    input wire [1:0]  ctrlin,
    input wire        din_en,
    input             evenin,

    output wire [31:0] dout,
    output wire [1:0]  ctrlout,
    output wire        dout_en,
    output wire        evenout
);

integer  i;

reg [57:0]  dscr      = '0;
reg [57:0]  poly      = '0;
reg [31:0]  tmp       = '0;
reg [31:0]  dout_r    = '0;
reg         xr        = '0;
reg [1:0]   ctrlout_r = '0;
reg         dout_en_r = '0;
reg         evenout_r = '0;

always @(dscr,din) begin
    poly = dscr;
    for (i=0;i<=31;i=i+1) begin
        xr = din[i] ^ poly[38] ^ poly[57];
        poly = {poly[56:0],din[i]};
        tmp[i] = xr;
    end
end

always @(posedge clk) begin
    if (din_en) begin
        dout_r    <=  tmp;
        dscr      <=  poly;
        ctrlout_r <=  ctrlin;
    end
end
always @(posedge clk) dout_en_r <= din_en;
always @(posedge clk) evenout_r <= evenin;

assign dout    = dout_r;
assign ctrlout = ctrlout_r;
assign dout_en = dout_en_r;
assign evenout = evenout_r;

endmodule

