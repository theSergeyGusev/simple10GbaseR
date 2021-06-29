`timescale 1ns/1ps

module top;

logic rst_ref, clk_ref;
logic rst_g  , clk_g;

localparam T_644 = 1.5515151515151516;
localparam T_156 = 6.4;
localparam T_g   = 20;

localparam XGMII_WIDTH_BASER = 64;
localparam XGMII_WIDTH_PMA   = 32;

// System Clock and Reset
initial begin clk_ref  = 0; forever begin #( T_644/2) clk_ref  = ~clk_ref ; end end
initial begin clk_g    = 0; forever begin #(   T_g/2) clk_g    = ~clk_g   ; end end

initial begin rst_ref  = 1; repeat (10) begin @(posedge  clk_ref); end rst_ref  = 0; end
initial begin rst_g    = 1; repeat (10) begin @(posedge  clk_g  ); end rst_g    = 0; end

xgmii_if #(.WIDTH (XGMII_WIDTH_PMA  )) if_pmaTx  ();
xgmii_if #(.WIDTH (XGMII_WIDTH_PMA  )) if_pmaRx  ();

test 
#(
    .XGMII_WIDTH_PMA   (XGMII_WIDTH_PMA  )
)
test_u 
(
    .pmaTx   (if_pmaTx  ),
    .pmaRx   (if_pmaRx  )
);

dut dut_u 
(
    .clk_ref (clk_ref    ), 
    .rst_ref (rst_ref    ), 
    .clk_glbl(clk_g      ), 
    .rst_glbl(rst_g      ),
    .pmaTx   (if_pmaTx   ),
    .pmaRx   (if_pmaRx   )
);

endmodule
