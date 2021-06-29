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

class Environment #(parameter XGMII_WIDTH_BASER = 64, parameter XGMII_WIDTH_PMA = 32);
    Ethpack_generator genBaser[];
    Ethpack_generator genPma  [];
    mailbox genBaser2drvBaser [];
    mailbox genPma2drvPma     [];
    event   drvBaser2genBaser [];
    event   drvPma2genPma     [];
    Driver2xgmii  #(.XGMII_WIDTH(XGMII_WIDTH_BASER)) drvBaser[];
    Driver2xgmii  #(.XGMII_WIDTH(XGMII_WIDTH_PMA  )) drvPma  [];
    Monitor4xgmii #(.XGMII_WIDTH(XGMII_WIDTH_PMA  )) monPma  [];
    Monitor4xgmii #(.XGMII_WIDTH(XGMII_WIDTH_BASER)) monBaser[];
    Config cfg;
    Scoreboard scb[];
    virtual xgmii_if#(XGMII_WIDTH_BASER).TbTx baserTx;
    virtual xgmii_if#(XGMII_WIDTH_BASER).TbRx baserRx;
    virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbTx pmaTx;
    virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbRx pmaRx;

    extern function new(input virtual xgmii_if#(XGMII_WIDTH_BASER).TbTx baserTx, 
                        input virtual xgmii_if#(XGMII_WIDTH_BASER).TbRx baserRx, 
                        input virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbTx pmaTx, 
                        input virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbRx pmaRx);
    extern virtual function void build();
    extern virtual task run();
    extern virtual task force_linkdown_baser();
    extern virtual task force_linkdown_pma();
    extern virtual function void wrap_up();

endclass

function Environment::new
    (
        input virtual xgmii_if#(XGMII_WIDTH_BASER).TbTx baserTx, 
        input virtual xgmii_if#(XGMII_WIDTH_BASER).TbRx baserRx, 
        input virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbTx pmaTx,
        input virtual xgmii_if#(XGMII_WIDTH_PMA  ).TbRx pmaRx
    );

    this.baserTx  = baserTx;
    this.baserRx  = baserRx;
    this.pmaTx = pmaTx;
    this.pmaRx = pmaRx;

    cfg = new();
endfunction

function void Environment::build();

    genBaser  = new[1];
    genPma    = new[1];
    drvBaser  = new[1];
    drvPma    = new[1];
    genBaser2drvBaser = new[1];
    genPma2drvPma     = new[1];
    drvBaser2genBaser = new[1];
    drvPma2genPma     = new[1];
    scb = new[2];
    scb[0] = new(cfg,"baser2pma");
    scb[1] = new(cfg,"pma2baser");

    genBaser2drvBaser[0] = new();
    genPma2drvPma    [0] = new();
    genBaser         [0] = new(genBaser2drvBaser[0], drvBaser2genBaser[0], cfg , "baser");
    genPma           [0] = new(genPma2drvPma    [0], drvPma2genPma    [0], cfg , "pma");
    drvBaser         [0] = new(genBaser2drvBaser[0], drvBaser2genBaser[0], cfg,  baserTx, 64, 0, "baser");
    drvPma           [0] = new(genPma2drvPma    [0], drvPma2genPma    [0], cfg,  pmaTx, 32, 1, "pma");

    monBaser  = new[1];
    monPma    = new[1];
    monBaser [0] = new(baserRx, "baser");
    monPma   [0] = new(pmaRx, "pma");


    // Connect the scoreboard with callbacks
    begin
        Scb_Driver_cbs   #(.XGMII_WIDTH(XGMII_WIDTH_BASER)) sdcBaser  = new(scb[0]);
        Scb_Driver_cbs   #(.XGMII_WIDTH(XGMII_WIDTH_PMA  )) sdcPma    = new(scb[1]);
        Scb_Monitor_cbs  #(.XGMII_WIDTH(XGMII_WIDTH_BASER)) smcBaser  = new(scb[1]);
        Scb_Monitor_cbs  #(.XGMII_WIDTH(XGMII_WIDTH_PMA  )) smcPma    = new(scb[0]);
        foreach (drvBaser[i] ) drvBaser[i].cbsq.push_back(sdcBaser)  ;  // Add scb to every driver
        foreach (drvPma  [i] ) drvPma[i].cbsq.push_back(sdcPma);  // Add scb to every driver
        foreach (monBaser[i] ) monBaser[i].cbsq.push_back(smcBaser)  ;  // Add scb to every monitor
        foreach (monPma  [i] ) monPma[i].cbsq.push_back(smcPma);  // Add scb to every monitor
    end

endfunction

task Environment::run();
    
    int num_genBaser_running;
    int num_genPma_running;
    num_genBaser_running = 1;
    num_genPma_running = 1;

    // For each input RX channel, start generator and driver
    foreach(genBaser[i]) begin
        int j=i;      // Automatic variable to hold index in spawned threads
        fork begin
            genBaser[j].run();       // Wait for generator to finish
            num_genBaser_running--;  // Decrement driver count
        end
        drvBaser[j].run();
        join_none
    end

    foreach(genPma[i]) begin
        int j=i;      // Automatic variable to hold index in spawned threads
        fork begin
            genPma[j].run();       // Wait for generator to finish
            num_genPma_running--;  // Decrement driver count
        end
        drvPma[j].run();
        join_none
    end

    if (cfg.test_force_linkdown==1) begin
        fork begin
            this.force_linkdown_baser();
        end
        join_none
    end
    if (cfg.test_force_linkdown==1) begin
        fork begin
            this.force_linkdown_pma();
        end
        join_none
    end

    foreach(monPma[i]) begin
        int j=i;       // Automatic variable to hold index in spawned threads
        fork
            monPma[j].run();
        join_none
    end

    foreach(monBaser[i]) begin
        int j=i;       // Automatic variable to hold index in spawned threads
        fork
            monBaser[j].run();
        join_none
    end

    // Wait for all generators to finish, or time-out
    fork : timeout_block
        wait ((num_genBaser_running == 0) & (num_genPma_running == 0));
        begin
            repeat (1000000) @baserTx.tbtx_cb;
            $display("@%0t: %m Env: ERROR: Timeout while waiting for generators to finish", $time);
            cfg.nErrors = cfg.nErrors + 1;
        end
    join_any
    disable timeout_block;

    // Wait a little longer for the data flow through switch, into monitors, and scoreboards
    repeat (1000) @baserTx.tbtx_cb;

endtask : run

task Environment::force_linkdown_baser();
    int pause;
    int linkdown;
    forever begin
        @drvPma2genPma[0];
        pause = $urandom_range(500,600);
        linkdown = $urandom_range(200,300);
        repeat (pause) @baserTx.tbtx_cb;
        top.dut_u.force_linkdown_baser = 1;
        repeat (linkdown) @baserTx.tbtx_cb;
        top.dut_u.force_linkdown_baser = 0;
    end 
endtask

task Environment::force_linkdown_pma();
    int pause;
    int linkdown;
    forever begin
        @drvBaser2genBaser[0];
        pause = $urandom_range(500,600);
        linkdown = $urandom_range(200,300);
        repeat (pause) @pmaTx.tbtx_cb;
        top.dut_u.force_linkdown_pma = 1;
        repeat (linkdown) @pmaTx.tbtx_cb;
        top.dut_u.force_linkdown_pma = 0;
    end 
endtask

function void Environment::wrap_up();
    scb[0].wrap_up;
    scb[1].wrap_up;
    $display("@%0t: Env: End of simulation, %0d ERROR, %0d WARNING", $time, cfg.nErrors, cfg.nWarnings);
endfunction

`endif 

