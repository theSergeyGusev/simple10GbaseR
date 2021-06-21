`ifndef ETHPACK_GENERATOR__SV
`define ETHPACK_GENERATOR__SV

`include "ethpack.sv"
`include "config.sv"

typedef class Ethpack_generator;

class Ethpack_generator_cbs;
    virtual task post_gen
        (
            input Ethpack_generator gen,
            input Ethpack pack
        );
    endtask : post_gen
endclass

class Ethpack_generator;

    mailbox  gen2drv;    // Mailbox to driver for packets
    event    drv2gen;    // Event from driver when done transmit pack
    string   generator_id = "";
    Ethpack_generator_cbs cbsq[$];

    Config   cfg;
    Ethpack  pack;

    int len_packet_current;

    extern function new(input mailbox gen2drv, input event drv2gen, input Config cfg, input string generator_id);
    extern function void gen_len_packet (ref int len_packet_current, input Config cfg);

    task run();
        repeat (cfg.gen_param.count_packets) begin
            pack = new();
            pack.generate_ip_pack(len_packet_current);
            gen_len_packet(len_packet_current,cfg);
            pack.display_pack($sformatf("@%0t: Generator_%s: ", $time, generator_id));
            foreach (cbsq[i]) begin
                cbsq[i].post_gen(this, pack);
            end
            gen2drv.put(pack);
            @drv2gen;
        end
    endtask

endclass

function Ethpack_generator::new(
        input mailbox gen2drv, 
        input event drv2gen, 
        input Config cfg, 
        input string generator_id
    ); 
    this.gen2drv      = gen2drv;
    this.drv2gen      = drv2gen;
    this.cfg          = cfg;
    this.generator_id = generator_id;
    this.pack         = new();

    len_packet_current = cfg.gen_param.len_packet_start;

endfunction

function void Ethpack_generator::gen_len_packet(
        ref int len_packet_current, 
        input Config cfg
    );
    if (cfg.gen_param.len_packet_type == "rnd") begin
        len_packet_current = $urandom_range(cfg.gen_param.len_packet_start,cfg.gen_param.len_packet_finish);
    end
    else if (cfg.gen_param.len_packet_type == "lin") begin
        if (len_packet_current >= cfg.gen_param.len_packet_finish) begin
            len_packet_current = cfg.gen_param.len_packet_start;
        end
        else begin
            len_packet_current = len_packet_current + 1; 
        end
    end
endfunction

`endif

