`include "environment.sv"

program automatic test
#(
    parameter XGMII_WIDTH_PMA   = 32
)
(
    xgmii_if.TbTx pmaTx  ,
    xgmii_if.TbRx pmaRx  
);

Environment #(.XGMII_WIDTH_PMA(XGMII_WIDTH_PMA)) env;

initial begin
    env = new(pmaTx, pmaRx);
    env.build();
    env.run();
    env.wrap_up();
end

endprogram 

