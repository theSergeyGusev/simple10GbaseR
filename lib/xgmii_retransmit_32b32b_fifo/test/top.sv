`timescale 1ns/1ps

module top;

logic rst_rx, clk_rx;
logic rst_tx, clk_tx;

localparam T_rx = 3.1;
localparam T_tx = 3.1;

// System Clock and Reset
initial begin clk_rx  = 0; forever begin #(T_rx/2) clk_rx  = ~clk_rx ; end end
initial begin clk_tx  = 0; forever begin #(T_tx/2) clk_tx  = ~clk_tx ; end end

initial begin rst_rx  = 1; repeat (10) begin @(posedge clk_rx); end rst_rx  = 0; end
initial begin rst_tx  = 1; repeat (10) begin @(posedge clk_tx); end rst_tx  = 0; end

xgmii_if #(.WIDTH (32)) if_0();
xgmii_if #(.WIDTH (32)) if_1();

test 
#(
    .XGMII_WIDTH (32)
)
test_u 
(
    .Tx(if_0),
    .Rx(if_1)
);

dut dut_u 
(
    .clk_rx(clk_rx), 
    .clk_tx(clk_tx), 
    .rst_rx(rst_rx), 
    .rst_tx(rst_tx), 
    .Tx    (if_0),
    .Rx    (if_1)
);

endmodule
