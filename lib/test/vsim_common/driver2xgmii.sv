`ifndef DRIVER2XGMII__SV
`define DRIVER2XGMII__SV

`include "ethpack.sv"
`include "config.sv"

typedef class Driver2xgmii;

// driver callback class
class Driver2xgmii_cbs#(parameter XGMII_WIDTH = 64);
    virtual task pre_tx
        (
            input Driver2xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) drv,
            input Ethpack pack
        );
    endtask : pre_tx

    virtual task pre_tx_word
        (
            input Driver2xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) drv
        );
    endtask : pre_tx_word

    virtual task post_tx
        (
            input Driver2xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) drv,
            input Ethpack pack
        );
    endtask : post_tx
endclass

class Driver2xgmii #(parameter XGMII_WIDTH = 64);

    mailbox gen2drv; 
    event   drv2gen;
    virtual xgmii_if#(XGMII_WIDTH).TbTx Tx;
    string  driver_id = "";
    Driver2xgmii_cbs #(.XGMII_WIDTH(XGMII_WIDTH)) cbsq[$]; // queue of callback objects
    Config  cfg;
    int valid_ena = 0;
    int pause_ena = 0;

    extern function new(input mailbox gen2drv, input event drv2gen, input Config cfg, input virtual xgmii_if#(XGMII_WIDTH).TbTx Tx, int valid_ena, int pause_ena, string driver_id);
    extern task run();
    extern task send (ref byte raw_data[$], ref bit ctrl_data[$], ref int valid_ena_current, ref int pause_ena_current);

endclass

function Driver2xgmii::new
    (
        input mailbox gen2drv,
        input event drv2gen,
        input Config cfg, 
        input virtual xgmii_if#(XGMII_WIDTH).TbTx Tx,
        input int valid_ena, 
        input int pause_ena, 
        input string driver_id
    );
    this.gen2drv   = gen2drv;
    this.drv2gen   = drv2gen;
    this.Tx        = Tx;
    this.driver_id = driver_id;
    this.cfg       = cfg;
    this.valid_ena = valid_ena;
    this.pause_ena = pause_ena;
endfunction


task Driver2xgmii::run();
    Ethpack pack;
    byte raw_data[$];
    bit  ctrl_data[$];
    int raw_data_size = 0;
    int pause_after;
    int valid_ena_current;
    int pause_ena_current;

    Tx.tbtx_cb.data  <= {(XGMII_WIDTH/8){8'h07}}; 
    Tx.tbtx_cb.ctrl  <= {(XGMII_WIDTH/8){1'h1}}; 
    Tx.tbtx_cb.ena   <= 0; 

    while (Tx.tbtx_cb.rst!=0) @Tx.tbtx_cb; 
    repeat (128) begin raw_data.push_back(8'h07); ctrl_data.push_back(1);end
    send(raw_data,ctrl_data,valid_ena_current,pause_ena_current);
    
    forever begin
        if (gen2drv.try_peek(pack) & Tx.tbtx_cb.rdy===1'b1) begin
            // pre-transmit callbacks
            foreach (cbsq[i]) begin
                cbsq[i].pre_tx(this, pack);
            end
            pack.display_pack($sformatf("@%0t: Driver_%s: ", $time, driver_id));
            pause_after = (pack.raw_data.size()*100/cfg.gen_param.rate)-pack.raw_data.size();

            foreach (pack.raw_data[i]) begin 
                raw_data.push_back(pack.raw_data[i]); 
                if (i==0) begin ctrl_data.push_back(1); end
                else      begin ctrl_data.push_back(0); end
            end
            
            send(raw_data,ctrl_data,valid_ena_current,pause_ena_current);
            // post-transmit callbacks
            foreach (cbsq[i]) begin
                cbsq[i].post_tx(this, pack);
            end
            ->drv2gen; // tell the generator we are done with this packet

            raw_data.push_back(8'hFD); ctrl_data.push_back(1);
            repeat (11) begin raw_data.push_back(8'h07); ctrl_data.push_back(1);end

            if (11 < pause_after) begin
                repeat (pause_after-11) begin raw_data.push_back(8'h07); ctrl_data.push_back(1);end
            end
            raw_data_size = raw_data.size();
            repeat ((raw_data_size%4==0)?(0):(4-raw_data_size%4)) begin raw_data.push_back(8'h07); ctrl_data.push_back(1);end
            send(raw_data,ctrl_data,valid_ena_current,pause_ena_current);
            gen2drv.get(pack); // remove packet from the mailbox
        end
        else begin
            repeat (128) begin raw_data.push_back(8'h07); ctrl_data.push_back(1);end
            send(raw_data,ctrl_data,valid_ena_current,pause_ena_current);
        end
    end
endtask

task Driver2xgmii::send(ref byte raw_data[$], ref bit ctrl_data[$], ref int valid_ena_current, ref int pause_ena_current);
    logic [XGMII_WIDTH-1:0] send_data;
    logic [(XGMII_WIDTH/8)-1:0] send_ctrl;
    int len = raw_data.size()/(XGMII_WIDTH/8); 

    int p=0;
    while (p<len) begin
        foreach (cbsq[i]) begin
            cbsq[i].pre_tx_word(this);
        end
        if (valid_ena_current < valid_ena) begin
            for (int l=0; l<(XGMII_WIDTH/8); l++) begin
                send_data[(l*8)+:8] = '{raw_data.pop_front()};
                send_ctrl[l]        = '{ctrl_data.pop_front()};
            end    
            Tx.tbtx_cb.data <= send_data;
            Tx.tbtx_cb.ctrl <= send_ctrl;
            Tx.tbtx_cb.ena  <= 1;
            valid_ena_current = valid_ena_current + 1;
            @Tx.tbtx_cb;
            p=p+1;
        end
        else if (pause_ena_current < pause_ena) begin
            Tx.tbtx_cb.data <= '0;
            Tx.tbtx_cb.ctrl <= '0;
            Tx.tbtx_cb.ena  <= 0;
            pause_ena_current = pause_ena_current + 1;
            @Tx.tbtx_cb;
        end
        else begin
            valid_ena_current = 0;
            pause_ena_current = 0;
        end
    end
    foreach (cbsq[i]) begin
        cbsq[i].pre_tx_word(this);
    end
    Tx.tbtx_cb.data  <= {(XGMII_WIDTH/8){8'h07}}; 
    Tx.tbtx_cb.ctrl  <= {(XGMII_WIDTH/8){1'h1}}; 
    Tx.tbtx_cb.ena   <= 1;
endtask

`endif 

