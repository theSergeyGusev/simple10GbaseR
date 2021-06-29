`ifndef INTERFACE__SV
`define INTERFACE__SV

interface xgmii_if #(parameter WIDTH = 32);

logic [(WIDTH-1):0] data;
logic [(WIDTH/8-1):0] ctrl;
logic rdy;
logic clk;
logic rst;
logic ena;

modport DutTx 
(
    output clk, 
    output rst, 
    input  data, 
    input  ctrl, 
    input  ena, 
    output rdy 
);

modport DutRx 
(
    output clk, 
    output rst, 
    output data, 
    output ctrl, 
    output ena, 
    input  rdy 
);

clocking tbtx_cb @(posedge clk);
    input  clk; 
    input  rst; 
    output data; 
    output ctrl; 
    output ena;
    input  rdy; 
endclocking

modport TbTx 
(
    clocking tbtx_cb
);

clocking tbrx_cb @(posedge clk);
    input  clk; 
    input  rst; 
    input  data; 
    input  ctrl; 
    input  ena;
    output rdy; 
endclocking

modport TbRx 
(
    clocking tbrx_cb
);

endinterface

`endif 

