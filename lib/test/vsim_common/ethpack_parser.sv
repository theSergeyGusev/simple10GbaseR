`ifndef ETHPACK_PARSER__SV
`define ETHPACK_PARSER__SV

`include "ethpack.sv"
`include "ethpack_param.sv"

typedef class Ethpack_parser;

// driver callback class
class Ethpack_parser_cbs;
    virtual task post_parser
        (
            input Ethpack_parser prs,
            input Ethpack_param ethpack_param
        );
    endtask : post_parser
endclass

class Ethpack_parser;

    mailbox gen2parser; 
    event   parser2gen;
    mailbox parser2drv; 
    event   drv2parser;

    string parser_id;
    Ethpack pack;
    int pack_count;
    
    Ethpack_parser_cbs cbsq[$]; // queue of callback objects

    Ethpack_param ethpack_param;

    extern function new(input mailbox gen2parser, input event parser2gen, 
                        input mailbox parser2drv, input event drv2parser, 
                        input string parser_id);

    extern task run();

endclass

function Ethpack_parser::new(
        input mailbox gen2parser, 
        input event parser2gen, 
        input mailbox parser2drv, 
        input event drv2parser, 
        input string parser_id
    ); 

    this.gen2parser = gen2parser ;
    this.parser2gen = parser2gen ;
    this.parser2drv = parser2drv ;
    this.drv2parser = drv2parser ;

    this.pack_count    = 0;
    this.parser_id     = parser_id;
    this.pack          = new();
    this.ethpack_param = new();
endfunction

task Ethpack_parser::run();
    forever begin
        gen2parser.peek(pack);
        begin : rcvpack
            ethpack_param.parse(pack);
            ethpack_param.add_param_id(pack_count);
            ethpack_param.display($sformatf("@%0t: Parser_%s: ", $time, parser_id));            
        end
        foreach (cbsq[i]) begin
            cbsq[i].post_parser(this, ethpack_param);
        end
        parser2drv.put(pack);
        @drv2parser;
        gen2parser.get(pack);
        ->parser2gen;
        pack_count = pack_count + 1;
    end
endtask

`endif

