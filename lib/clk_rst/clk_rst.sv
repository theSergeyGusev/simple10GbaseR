module clk_rst
(
    input wire clk,
    input wire rst,

    output wire clk_glbl,
    output wire rst_glbl,

    input  wire refclk,
    input  wire tr_fpll_powerdown,
    output wire tr_fpll_pll_locked,   
    output wire tr_fpll_tx_serial_clk,
    output wire tr_fpll_pll_cal_busy 
);

`ifdef SIMULATION
    localparam RST_WIDTH = 2;
`else
    localparam RST_WIDTH = 20;
`endif

wire  tr_fpll_pll_refclk0_w    ;
wire  tr_fpll_pll_powerdown_w  ;
wire  tr_fpll_pll_locked_w     ;
wire  tr_fpll_tx_serial_clk_w  ;
wire  tr_fpll_pll_cal_busy_w   ; 
    
reg [RST_WIDTH-1:0] rst_count_r = 0;
reg                 rst_glbl_r  = 0;

////////////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin
    if (rst) begin
        rst_count_r <= 0;
    end
    else begin
        if (!rst_count_r[RST_WIDTH-1]) begin
            rst_count_r <= rst_count_r + {{(RST_WIDTH-1){1'b0}},1'd1};
        end
    end
    rst_glbl_r <= !rst_count_r[RST_WIDTH-1];
end

assign clk_glbl = clk;
assign rst_glbl = rst_glbl_r;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
assign tr_fpll_pll_refclk0_w   = refclk;
assign tr_fpll_pll_powerdown_w = tr_fpll_powerdown;

tr_fpll tr_fpll_u
(
    .pll_refclk0   (tr_fpll_pll_refclk0_w  ), // input  
    .pll_powerdown (tr_fpll_pll_powerdown_w), // input  
    .pll_locked    (tr_fpll_pll_locked_w   ), // output 
    .tx_serial_clk (tr_fpll_tx_serial_clk_w), // output 
    .pll_cal_busy  (tr_fpll_pll_cal_busy_w )  // output 
    );

assign tr_fpll_pll_locked    = tr_fpll_pll_locked_w     ;
assign tr_fpll_tx_serial_clk = tr_fpll_tx_serial_clk_w  ;  
assign tr_fpll_pll_cal_busy  = tr_fpll_pll_cal_busy_w   ;
////////////////////////////////////////////////////////////////////////////////

endmodule
