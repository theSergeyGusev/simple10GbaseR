`ifndef PCAP_GENERATOR__SV
`define PCAP_GENERATOR__SV

`include "ethpack.sv"
`include "config.sv"

class Pcap_generator;

    mailbox  gen2drv;    // Mailbox to driver for packets
    event    drv2gen;    // Event from driver when done transmit pack
    string   generator_id = "";

    Config   cfg;
    Ethpack  pack;

    typedef struct {
        bit [31:00] magic         ;
        bit [15:00] version_major ;
        bit [15:00] version_minor ;
        bit [31:00] thiszone      ;
        bit [31:00] sigfigs       ;
        bit [31:00] snaplen       ;
        bit [31:00] linktype      ;
    } pcap_file_hdr_t;
    typedef struct {
        bit [31:00] tv_sec  ;
        bit [31:00] tv_usec ;
        bit [31:00] caplen  ;
        bit [31:00] len     ;
    } pcap_pkt_hdr_t;

    extern function new(input mailbox gen2drv, input event drv2gen, input Config cfg, input string generator_id);
    extern task run();

endclass

function Pcap_generator::new(
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
endfunction

task Pcap_generator::run();
    integer  fd;
    byte data[$]={};
    byte data_8b=0;
    int len = 0;
    int swapped_pcap = 0;
    bit [31:00] tmp_swapped;
    pcap_file_hdr_t pcap_file_hdr;
    pcap_pkt_hdr_t pcap_pkt_hdr;
    int  pcap_pkt_hdr_status = 0;
    int  pcap_file_hdr_status = 0;
    int  data_8b_status = 0;

    fd = $fopen(cfg.pcap_rd_path,"r");    
    if (fd) begin $display("file was opened %s: %0d" ,cfg.pcap_rd_path, fd); end
    else    begin $display("file was NOT opened %s: %0d" ,cfg.pcap_rd_path, fd); end

    pcap_file_hdr_status = $fread(pcap_file_hdr,fd);
    //$display("pcap magic          %x", pcap_file_hdr.magic         );
    //$display("pcap version_major  %x", pcap_file_hdr.version_major );
    //$display("pcap version_minor  %x", pcap_file_hdr.version_minor );
    //$display("pcap thiszone       %x", pcap_file_hdr.thiszone      );
    //$display("pcap sigfigs        %x", pcap_file_hdr.sigfigs       );
    //$display("pcap snaplen        %x", pcap_file_hdr.snaplen       );
    //$display("pcap linktype       %x", pcap_file_hdr.linktype      );
    //$display("");
    
    swapped_pcap = (pcap_file_hdr.magic==32'hd4c3b2a1) ? (1) : (0);

    while(!$feof(fd)) begin
        pcap_pkt_hdr_status = $fread(pcap_pkt_hdr,fd);
        if (pcap_pkt_hdr_status!=16) begin
            break;
        end 
        //$display("pcap tv_sec  %x", pcap_pkt_hdr.tv_sec  );
        //$display("pcap tv_usec %x", pcap_pkt_hdr.tv_usec );
        //$display("pcap caplen  %x", pcap_pkt_hdr.caplen  );
        //$display("pcap len     %x", pcap_pkt_hdr.len     );
        //$display("");
        if (swapped_pcap)begin
            tmp_swapped = pcap_pkt_hdr.tv_sec  ; pcap_pkt_hdr.tv_sec  = {tmp_swapped[7:0],tmp_swapped[15:8],tmp_swapped[23:16],tmp_swapped[31:24]};
            tmp_swapped = pcap_pkt_hdr.tv_usec ; pcap_pkt_hdr.tv_usec = {tmp_swapped[7:0],tmp_swapped[15:8],tmp_swapped[23:16],tmp_swapped[31:24]};
            tmp_swapped = pcap_pkt_hdr.caplen  ; pcap_pkt_hdr.caplen  = {tmp_swapped[7:0],tmp_swapped[15:8],tmp_swapped[23:16],tmp_swapped[31:24]};
            tmp_swapped = pcap_pkt_hdr.len     ; pcap_pkt_hdr.len     = {tmp_swapped[7:0],tmp_swapped[15:8],tmp_swapped[23:16],tmp_swapped[31:24]};
        end
        else begin
            tmp_swapped = pcap_pkt_hdr.tv_sec  ; pcap_pkt_hdr.tv_sec  = tmp_swapped;
            tmp_swapped = pcap_pkt_hdr.tv_usec ; pcap_pkt_hdr.tv_usec = tmp_swapped;
            tmp_swapped = pcap_pkt_hdr.caplen  ; pcap_pkt_hdr.caplen  = tmp_swapped;
            tmp_swapped = pcap_pkt_hdr.len     ; pcap_pkt_hdr.len     = tmp_swapped;
        end

        pack = new();
        
        data = {8'hFB,8'h55,8'h55,8'h55,8'h55,8'h55,8'h55,8'hD5};
        data_8b=0;
        len = 0;
        while (len<pcap_pkt_hdr.len) begin
            data_8b_status = $fread(data_8b,fd);
            data.push_back(data_8b);
            len = len + 1;
        end
        pack.append(data);
        pack.fill_crc();

        pack.display_pack      ($sformatf("@%0t: Generator_%s: ", $time, generator_id));
        gen2drv.put(pack);
        @drv2gen;
    end
endtask

`endif

