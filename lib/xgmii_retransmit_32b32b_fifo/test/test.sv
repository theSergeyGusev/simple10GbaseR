`include "environment.sv"

program automatic test
#(
    parameter XGMII_WIDTH = 32
)
(
    xgmii_if.TbTx Tx,
    xgmii_if.TbRx Rx
);

Environment #(.XGMII_WIDTH(XGMII_WIDTH)) env;

initial begin
    env = new(Tx, Rx);
    env.build();
    env.run();
    env.wrap_up();
end

endprogram 

