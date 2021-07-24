`ifndef ENVIRONMENT__SV
`define ENVIRONMENT__SV

`include "ethpack_generator.sv"
`include "driver2xgmii.sv"
`include "monitor4xgmii.sv"
`include "config.sv"
`include "scoreboard_pack.sv"

/////////////////////////////////////////////////////////
// Call scoreboard from Driver using callbacks
/////////////////////////////////////////////////////////
class Scb_Driver_cbs #(parameter XGMII_WIDTH = 64) extends Driver2xgmii_cbs #(.XGMII_WIDTH(XGMII_WIDTH));
    Scoreboard scb;

    function new(Scoreboard scb);
        this.scb = scb;
    endfunction

    // Send received pack to scoreboard
    virtual task post_tx(input Driver2xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) drv, input Ethpack pack);
        scb.save_expected(pack);
    endtask
endclass 

/////////////////////////////////////////////////////////
// Call scoreboard from Monitor using callbacks
/////////////////////////////////////////////////////////
class Scb_Monitor_cbs #(parameter XGMII_WIDTH = 64) extends Monitor4xgmii_cbs #(.XGMII_WIDTH(XGMII_WIDTH));
    Scoreboard scb;

    function new(Scoreboard scb);
        this.scb = scb;
    endfunction

    // Send received cell to scoreboard
    virtual task post_rx(input Monitor4xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) mon, input Ethpack pack);
        scb.check_actual(pack);
    endtask
endclass 

class Environment #(parameter XGMII_WIDTH = 32);
    Ethpack_generator gen[];
    mailbox gen2drv[];
    event   drv2gen[];
    Driver2xgmii  #(.XGMII_WIDTH(XGMII_WIDTH)) drv[];
    Monitor4xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) mon[];
    Config cfg;
    Scoreboard scb;
    virtual xgmii_if#(XGMII_WIDTH).TbTx Tx;
    virtual xgmii_if#(XGMII_WIDTH).TbRx Rx;

    extern function new(input virtual xgmii_if#(XGMII_WIDTH).TbTx Tx, input virtual xgmii_if#(XGMII_WIDTH).TbRx Rx);
    extern virtual function void build();
    extern virtual task run();
    extern virtual function void wrap_up();

endclass

function Environment::new
    (
        input virtual xgmii_if#(XGMII_WIDTH ).TbTx Tx, 
        input virtual xgmii_if#(XGMII_WIDTH).TbRx Rx
    );

    this.Tx = Tx;
    this.Rx = Rx;

    cfg = new();
endfunction

function void Environment::build();

    gen = new[1];
    drv = new[1];
    gen2drv = new[1];
    drv2gen = new[1];
    scb = new(cfg,"");

    gen2drv[0] = new();
    gen[0] = new(gen2drv[0], drv2gen[0], cfg , "");
    drv[0] = new(gen2drv[0], drv2gen[0], cfg, Tx, 32, 1, "");

    mon = new[1];
    mon[0] = new(Rx, "");

    // Connect the scoreboard with callbacks
    begin
        Scb_Driver_cbs  #(.XGMII_WIDTH(XGMII_WIDTH)) sdc = new(scb);
        Scb_Monitor_cbs #(.XGMII_WIDTH(XGMII_WIDTH)) smc = new(scb);
        foreach (drv[i]) drv[i].cbsq.push_back(sdc);  // Add scb to every driver
        foreach (mon[i]) mon[i].cbsq.push_back(smc);  // Add scb to every monitor
    end

endfunction

task Environment::run();
    
    int num_gen_running;
    num_gen_running = 1;

    // For each input RX channel, start generator and driver
    foreach(gen[i]) begin
        int j=i;      // Automatic variable to hold index in spawned threads
        fork begin
            gen[j].run();       // Wait for generator to finish
            num_gen_running--;  // Decrement driver count
        end
        drv[j].run();
        join_none
    end

    foreach(mon[i]) begin
        int j=i;       // Automatic variable to hold index in spawned threads
        fork
            mon[j].run();
        join_none
    end

    // Wait for all generators to finish, or time-out
    fork : timeout_block
        wait (num_gen_running == 0);
        begin
            repeat (1000000) @(Tx.tbtx_cb);
            $display("@%0t: %m Env: ERROR: Timeout while waiting for generators to finish", $time);
            cfg.nErrors = cfg.nErrors + 1;
        end
    join_any
    disable timeout_block;

    // Wait a little longer for the data flow through switch, into monitors, and scoreboards
repeat (1000) @(Tx.tbtx_cb);

endtask : run

function void Environment::wrap_up();
    scb.wrap_up;
    $display("@%0t: Env: End of simulation, %0d ERROR, %0d WARNING", $time, cfg.nErrors, cfg.nWarnings);
endfunction

`endif 

