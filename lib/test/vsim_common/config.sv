`ifndef CONFIG__SV
`define CONFIG__SV

import test_type::gen_param_t;

class Config;
    int nErrors, nWarnings;      // Number of errors, warnings during simulation
    int seed;
    string pcap_rd_path="";
    int test_force_linkdown;
    gen_param_t gen_param;

    extern function new();
    extern virtual function void display();

endclass 

function Config::new();
    int value_plusargs_status=0;
    this.seed = $get_initial_random_seed;

    if ($test$plusargs(        "test_force_linkdown")) begin value_plusargs_status=$value$plusargs(        "test_force_linkdown=%d", this.test_force_linkdown         ); end
    if ($test$plusargs(             "generator_rate")) begin value_plusargs_status=$value$plusargs(             "generator_rate=%d", this.gen_param.rate              ); end
    if ($test$plusargs(               "pcap_rd_path")) begin value_plusargs_status=$value$plusargs(               "pcap_rd_path=%s", this.pcap_rd_path                ); end
    if ($test$plusargs(    "generator_count_packets")) begin value_plusargs_status=$value$plusargs(    "generator_count_packets=%d", this.gen_param.count_packets     ); end
    if ($test$plusargs(  "generator_len_packet_type")) begin value_plusargs_status=$value$plusargs(  "generator_len_packet_type=%s", this.gen_param.len_packet_type   ); end
    if ($test$plusargs( "generator_len_packet_start")) begin value_plusargs_status=$value$plusargs( "generator_len_packet_start=%d", this.gen_param.len_packet_start  ); end
    if ($test$plusargs("generator_len_packet_finish")) begin value_plusargs_status=$value$plusargs("generator_len_packet_finish=%d", this.gen_param.len_packet_finish ); end

    this.display();

endfunction

function void Config::display();
    $display("Cfg: seed=%0d"                       , seed                        );
    $display("Cfg: test_force_linkdown=%0d"        , test_force_linkdown         );
    $display("Cfg: pcap_rd_path=%s"                , pcap_rd_path                );
    $display("Cfg: gen_param.rate=%0d"             , gen_param.rate              );
    $display("Cfg: gen_param.count_packets=%0d"    , gen_param.count_packets     );
    $display("Cfg: gen_param.len_packet_type=%s"   , gen_param.len_packet_type   );
    $display("Cfg: gen_param.len_packet_start=%0d" , gen_param.len_packet_start  );
    $display("Cfg: gen_param.len_packet_finish=%0d", gen_param.len_packet_finish );
    $display;
endfunction 

`endif

