`ifndef MONITOR4XGMII__SV
`define MONITOR4XGMII__SV

`include "ethpack.sv"

typedef class Monitor4xgmii;

// monitor callback class
class Monitor4xgmii_cbs#(parameter XGMII_WIDTH = 32);
    virtual task post_rx
        (
            input Monitor4xgmii #(.XGMII_WIDTH(XGMII_WIDTH)) mon,
            input Ethpack pack
        );
    endtask
endclass

class Monitor4xgmii #(parameter XGMII_WIDTH = 32);

    virtual xgmii_if#(XGMII_WIDTH).TbRx Rx;
    string monitor_id = "";
    Monitor4xgmii_cbs #(.XGMII_WIDTH(XGMII_WIDTH)) cbsq[$]; // queue of callback objects
    Ethpack pack;

    extern function new(input virtual xgmii_if#(XGMII_WIDTH).TbRx Rx, string monitor_id);
    extern task run();
    extern task receive (output Ethpack pack);

endclass

function Monitor4xgmii::new
    (
        input virtual xgmii_if#(XGMII_WIDTH).TbRx Rx,
        input string monitor_id
    );
    this.Rx        = Rx;
    this.monitor_id = monitor_id;
endfunction

task Monitor4xgmii::run();
    Ethpack pack;

    forever begin
        receive(pack);
        foreach (cbsq[i]) begin
            cbsq[i].post_rx(this, pack); // post-receive callback
        end
    end
endtask

task Monitor4xgmii::receive(output Ethpack pack);
    byte data[$]={};
    byte prev_byte;
    logic start = 0;
    logic stop = 0;

    //@(posedge Rx.clk);

    Rx.tbrx_cb.rdy <= 1;
    while (stop!=1) begin
        for (int i=0; i<(XGMII_WIDTH/8); i++) begin
            if (Rx.tbrx_cb.ctrl[i]==1 & Rx.tbrx_cb.ena==1 & start==1 & Rx.tbrx_cb.data[i*8+:8]==8'hFD) begin stop=1; end
            if (Rx.tbrx_cb.ctrl[i]==0 & Rx.tbrx_cb.ena==1) begin
                if (start==0 & ((i==1)|(i==5)) & (prev_byte==8'hFB)) begin data.push_back(prev_byte); start=1; end
                data.push_back(Rx.tbrx_cb.data[i*8+:8]);
            end
            if (Rx.tbrx_cb.ena==1) begin prev_byte = Rx.tbrx_cb.data[i*8+:8]; end
        end 
        @Rx.tbrx_cb;
    end
    start = 0;
    stop = 0;

    pack = new();
    pack.parse(data);
    pack.display_pack($sformatf("@%0t: Monitor_%s: ", $time, monitor_id));

endtask

`endif

