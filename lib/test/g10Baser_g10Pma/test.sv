`include "environment.sv"

program automatic test
#(
    parameter XGMII_WIDTH_BASER = 64,
    parameter XGMII_WIDTH_PMA   = 32
)
(
    xgmii_if.TbTx baserTx,
    xgmii_if.TbRx baserRx,
    xgmii_if.TbTx pmaTx  ,
    xgmii_if.TbRx pmaRx  
);

Environment #(.XGMII_WIDTH_BASER(XGMII_WIDTH_BASER),.XGMII_WIDTH_PMA(XGMII_WIDTH_PMA)) env;

initial begin
    env = new(baserTx, baserRx, pmaTx, pmaRx);
    env.build();
    env.run();
    env.wrap_up();
end

endprogram 

