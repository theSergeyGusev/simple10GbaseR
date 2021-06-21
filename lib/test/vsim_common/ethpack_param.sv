`ifndef ETHPACK_PARAM__SV
`define ETHPACK_PARAM__SV

import test_type::pack_stack_t;
typedef byte byteQueue[$];

`include "ethpack.sv"

class Ethpack_param;
    
    pack_stack_t pack_stack;
    int NoMDEntries; 
    int param_id;

    extern function new();
    extern function void parse(input Ethpack pack);
    extern function void add_pack_stack(input pack_stack_t pack_stack);
    extern function void add_param_id(input int param_id);
    extern function bit compare(input Ethpack_param ethpack_param);
    extern function void display(string s);
    extern function byteQueue fast_parser(ref byte message[$]);
    extern function bit [31:0] touInt32(byte field[$]);
    extern function bit [31:0] toInt32 (byte field[$]);
    extern function bit [63:0] touInt64(byte field[$]);
    extern function bit [63:0] toInt64 (byte field[$]);
    extern function string     toString(byte field[$]);

endclass

function Ethpack_param::new();
    NoMDEntries = 0; 
    param_id    = 0;
endfunction

function bit Ethpack_param::compare(input Ethpack_param ethpack_param);
    //$write(" search crc: %x",pack.crc);
    //$write(" in: %x",this.crc);
    //$display(); 
    if (this.pack_stack !== ethpack_param.pack_stack) return 0;
    return 1;
endfunction

function void Ethpack_param::parse(input Ethpack pack);
    byte fast_message[$];
   
    pack_stack.ethernet.preambule = {pack.raw_data[7],pack.raw_data[6],pack.raw_data[5],pack.raw_data[4],pack.raw_data[3],pack.raw_data[2],pack.raw_data[1],pack.raw_data[0]};
    pack_stack.ethernet.mac_dst   = {pack.raw_data[8],pack.raw_data[9],pack.raw_data[10],pack.raw_data[11],pack.raw_data[12],pack.raw_data[13]};
    pack_stack.ethernet.mac_src   = {pack.raw_data[14],pack.raw_data[15],pack.raw_data[16],pack.raw_data[17],pack.raw_data[18],pack.raw_data[19]};
    pack_stack.ethernet.tp        = {pack.raw_data[20],pack.raw_data[21]};
    pack_stack.vlan.id            = {pack.raw_data[22][3:0],pack.raw_data[23]};
    pack_stack.vlan.tp            = {pack.raw_data[24],pack.raw_data[25]};
    pack_stack.ip.proto           = {pack.raw_data[35]};
    pack_stack.ip.src             = {pack.raw_data[38],pack.raw_data[39],pack.raw_data[40],pack.raw_data[41]};
    pack_stack.ip.dst             = {pack.raw_data[42],pack.raw_data[43],pack.raw_data[44],pack.raw_data[45]};
    pack_stack.udp.src            = {pack.raw_data[46],pack.raw_data[47]};
    pack_stack.udp.dst            = {pack.raw_data[48],pack.raw_data[49]};
    pack_stack.fast.preambule     = {pack.raw_data[57],pack.raw_data[56],pack.raw_data[55],pack.raw_data[54]};
    fast_message                  = {pack.raw_data[58:$]};

    pack_stack.fast.pmap = touInt32(fast_parser(fast_message));
    pack_stack.fast.id   = touInt32(fast_parser(fast_message));
    if (pack_stack.fast.id==3613) begin
        pack_stack.fast.fast_3613.MsgSeqNum                = touInt32(fast_parser(fast_message));
        pack_stack.fast.fast_3613.SendingTime              = touInt64(fast_parser(fast_message));
        pack_stack.fast.fast_3613.LastUpdateTime           = touInt64(fast_parser(fast_message));
        pack_stack.fast.fast_3613.NoMDEntries              = touInt32(fast_parser(fast_message)); NoMDEntries = pack_stack.fast.fast_3613.NoMDEntries ;
        pack_stack.fast.fast_3613.seq = new[NoMDEntries]; 
        for (int i=0;i<NoMDEntries;i=i+1) begin
            pack_stack.fast.fast_3613.seq[i].MDUpdateAction           = touInt32(fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].MDEntryType              = toString(fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].MDEntryID                = toString(fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].Symbol                   = toString(fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].RptSeq                   = toInt32 (fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].TotalNumOfTrades         = toInt32 (fast_parser(fast_message));
            pack_stack.fast.fast_3613.seq[i].TradeValue_exp           = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].TradeValue_exp!=0) begin pack_stack.fast.fast_3613.seq[i].TradeValue_man = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].TradeValue_man=0; end
            pack_stack.fast.fast_3613.seq[i].OfferNbOr                = toInt32 (fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].BidNbOr                  = toInt32 (fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].MDEntryPx_exp            = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].MDEntryPx_exp  !=0) begin pack_stack.fast.fast_3613.seq[i].MDEntryPx_man   = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].MDEntryPx_man=0;   end
            pack_stack.fast.fast_3613.seq[i].MDEntrySize_exp          = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].MDEntrySize_exp!=0) begin pack_stack.fast.fast_3613.seq[i].MDEntrySize_man = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].MDEntrySize_man=0; end
            pack_stack.fast.fast_3613.seq[i].MDEntryDate              = touInt32(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].MDEntryTime              = touInt32(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].StartTime                = touInt32(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].QuoteCondition           = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].TradeCondition           = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].OpenCloseSettlFlag       = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_exp        = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_exp  !=0) begin pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_man   = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_man  =0; end
            pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_exp       = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_exp !=0) begin pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_man  = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_man =0; end
            pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_exp      = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_exp!=0) begin pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_man = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_man=0; end
            pack_stack.fast.fast_3613.seq[i].BidMarketSize_exp        = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].BidMarketSize_exp  !=0) begin pack_stack.fast.fast_3613.seq[i].BidMarketSize_man   = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].BidMarketSize_man  =0; end
            pack_stack.fast.fast_3613.seq[i].AskMarketSize_exp        = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].AskMarketSize_exp  !=0) begin pack_stack.fast.fast_3613.seq[i].AskMarketSize_man   = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].AskMarketSize_man  =0; end
            pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_exp      = toInt32 (fast_parser(fast_message)); if (pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_exp!=0) begin pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_man = toInt64(fast_parser(fast_message)); end else begin pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_man=0; end
            pack_stack.fast.fast_3613.seq[i].SettlDate                = touInt32(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].SettlDate2               = touInt32(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].SettleType               = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].CXFlag                   = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].TradingSessionID         = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].TradingSessionSubID      = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].TradingSession           = toString(fast_parser(fast_message)); 
            pack_stack.fast.fast_3613.seq[i].SecurityStatistics       = toString(fast_parser(fast_message)); 
        end
    end
endfunction

function void Ethpack_param::add_pack_stack(input pack_stack_t pack_stack);
    this.pack_stack = pack_stack;
endfunction

function void Ethpack_param::add_param_id(input int param_id);
    this.param_id = param_id;
endfunction

function byteQueue Ethpack_param::fast_parser(ref byte message[$]);
    byte fast_field[$];
    int i = 0;
    byte B;

    while (i<message.size) begin
        B=message.pop_front;
        fast_field.push_back(B);
        i=i+1;
        if (B[7]==1) begin
            break;
        end
    end
    return fast_field; 
endfunction

function bit [31:0] Ethpack_param::touInt32(byte field[$]);
    bit [31:0] ar = 0;
    for (int i=0; i<field.size(); i=i+1) begin
        ar = {ar[25:0],field[i][6:0]};
    end
    return ar;
endfunction
function bit [31:0] Ethpack_param::toInt32(byte field[$]);
    bit [31:0] ar = 0;
    for (int i=0; i<field.size(); i=i+1) begin
        ar = {ar[25:0],field[i][6:0]};
    end
    return ar;
endfunction
function bit [63:0] Ethpack_param::touInt64(byte field[$]);
    bit [63:0] ar;
    for (int i=0; i<field.size(); i=i+1) begin
        ar = {ar[57:0],field[i][6:0]};
    end
    return ar;
endfunction
function bit [63:0] Ethpack_param::toInt64(byte field[$]);
    bit [63:0] ar;
    for (int i=0; i<field.size(); i=i+1) begin
        ar = {ar[57:0],field[i][6:0]};
    end
    return ar;
endfunction
function string Ethpack_param::toString(byte field[$]);
    string ar="";
    for (int i=0; i<field.size(); i=i+1) begin
        if(i==(field.size()-1)) begin
            ar = {ar,{1'b0,field[i][6:0]}};
        end
        else begin
            ar = {ar,field[i]};
        end
    end
    return ar;
endfunction

function void Ethpack_param::display(input string s);
    $write("%s", s) ;
    $display();
    $write("param_id: %0d ", param_id); 
    $write("preambule: %16x " , pack_stack.ethernet.preambule);
    $write("mac_dst: %12x "   , pack_stack.ethernet.mac_dst);
    $write("mac_src: %12x "   , pack_stack.ethernet.mac_src);
    $write("tp: %4x "         , pack_stack.ethernet.tp);
    $write("vlan_id: %0d "   , pack_stack.vlan.id);
    $write("vlan_tp: %4x "  , pack_stack.vlan.tp);
    $write("ip_proto: %0d " , pack_stack.ip.proto);
    $write("ip_src: %8x "  , pack_stack.ip.src);
    $write("ip_dst: %8x "  , pack_stack.ip.dst);
    $write("udp_src: %4x "  , pack_stack.udp.src);
    $write("udp_dst: %4x "  , pack_stack.udp.dst);
    $display();
    $write("fast_preambule: %8x " , pack_stack.fast.preambule);
    $write("fast_pmap: %8x "      , pack_stack.fast.pmap);
    $write("fast_id: %0d "        , pack_stack.fast.id);
    $display();
    $write("fast_3613_MsgSeqNum: %8x "             ,       pack_stack.fast.fast_3613.MsgSeqNum             );
    $write("fast_3613_SendingTime: %16x "          ,       pack_stack.fast.fast_3613.SendingTime           );
    $write("fast_3613_LastUpdateTime: %16x "       ,       pack_stack.fast.fast_3613.LastUpdateTime        );
    $write("fast_3613_NoMDEntries: %8x "           ,       pack_stack.fast.fast_3613.NoMDEntries           );
    $display();
    for (int i=0;i<pack_stack.fast.fast_3613.seq.size();i=i+1) begin 
        $write("    seq %0d :", i);
        $write("fast_3613_MDUpdateAction: %8x "        ,       pack_stack.fast.fast_3613.seq[i].MDUpdateAction        );
        $write("fast_3613_MDEntryType: '%s' "          ,       pack_stack.fast.fast_3613.seq[i].MDEntryType           );
        $write("fast_3613_MDEntryID: '%s' "            ,       pack_stack.fast.fast_3613.seq[i].MDEntryID             );
        $write("fast_3613_Symbol: '%s' "               ,       pack_stack.fast.fast_3613.seq[i].Symbol                );
        $write("fast_3613_RptSeq: %0d "              , $signed(pack_stack.fast.fast_3613.seq[i].RptSeq               ));
        $write("fast_3613_TotalNumOfTrades: %0d "    , $signed(pack_stack.fast.fast_3613.seq[i].TotalNumOfTrades     ));
        $write("fast_3613_TradeValue_exp: %0d "      , $signed(pack_stack.fast.fast_3613.seq[i].TradeValue_exp       ));
        $write("fast_3613_TradeValue_man: %0d "      , $signed(pack_stack.fast.fast_3613.seq[i].TradeValue_man       ));
        $write("fast_3613_OfferNbOr: %0d "           , $signed(pack_stack.fast.fast_3613.seq[i].OfferNbOr            ));
        $write("fast_3613_BidNbOr: %0d "             , $signed(pack_stack.fast.fast_3613.seq[i].BidNbOr              ));
        $write("fast_3613_MDEntryPx_exp: %0d "       , $signed(pack_stack.fast.fast_3613.seq[i].MDEntryPx_exp        ));
        $write("fast_3613_MDEntryPx_man: %0d "       , $signed(pack_stack.fast.fast_3613.seq[i].MDEntryPx_man        ));
        $write("fast_3613_MDEntrySize_exp: %0d "     , $signed(pack_stack.fast.fast_3613.seq[i].MDEntrySize_exp      ));
        $write("fast_3613_MDEntrySize_man: %0d "     , $signed(pack_stack.fast.fast_3613.seq[i].MDEntrySize_man      ));
        $write("fast_3613_MDEntryDate: %0d "         ,         pack_stack.fast.fast_3613.seq[i].MDEntryDate           );
        $write("fast_3613_MDEntryTime: %0d "         ,         pack_stack.fast.fast_3613.seq[i].MDEntryTime           );
        $write("fast_3613_StartTime: %0d "           ,         pack_stack.fast.fast_3613.seq[i].StartTime             );
        $write("fast_3613_QuoteCondition: '%s' "     ,         pack_stack.fast.fast_3613.seq[i].QuoteCondition        );
        $write("fast_3613_TradeCondition: '%s' "     ,         pack_stack.fast.fast_3613.seq[i].TradeCondition        );
        $write("fast_3613_OpenCloseSettlFlag: '%s' " ,         pack_stack.fast.fast_3613.seq[i].OpenCloseSettlFlag    );
        $write("fast_3613_NetChgPrevDay_exp: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_exp    ));
        $write("fast_3613_NetChgPrevDay_man: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].NetChgPrevDay_man    ));
        $write("fast_3613_ChgFromWAPrice_exp: %0d "  , $signed(pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_exp   ));
        $write("fast_3613_ChgFromWAPrice_man: %0d "  , $signed(pack_stack.fast.fast_3613.seq[i].ChgFromWAPrice_man   ));
        $write("fast_3613_ChgOpenInterest_exp: %0d " , $signed(pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_exp  ));
        $write("fast_3613_ChgOpenInterest_man: %0d " , $signed(pack_stack.fast.fast_3613.seq[i].ChgOpenInterest_man  ));
        $write("fast_3613_BidMarketSize_exp: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].BidMarketSize_exp    ));
        $write("fast_3613_BidMarketSize_man: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].BidMarketSize_man    ));
        $write("fast_3613_AskMarketSize_exp: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].AskMarketSize_exp    ));
        $write("fast_3613_AskMarketSize_man: %0d "   , $signed(pack_stack.fast.fast_3613.seq[i].AskMarketSize_man    ));
        $write("fast_3613_ChgFromSettlmnt_exp: %0d " , $signed(pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_exp  ));
        $write("fast_3613_ChgFromSettlmnt_man: %0d " , $signed(pack_stack.fast.fast_3613.seq[i].ChgFromSettlmnt_man  ));
        $write("fast_3613_SettlDate: %0d "           ,         pack_stack.fast.fast_3613.seq[i].SettlDate             );
        $write("fast_3613_SettlDate2: %0d "          ,         pack_stack.fast.fast_3613.seq[i].SettlDate2            );
        $write("fast_3613_SettleType: '%s' "         ,         pack_stack.fast.fast_3613.seq[i].SettleType            );
        $write("fast_3613_CXFlag: '%s' "             ,         pack_stack.fast.fast_3613.seq[i].CXFlag                );
        $write("fast_3613_TradingSessionID: '%s' "   ,         pack_stack.fast.fast_3613.seq[i].TradingSessionID      );
        $write("fast_3613_TradingSessionSubID: '%s' ",         pack_stack.fast.fast_3613.seq[i].TradingSessionSubID   );
        $write("fast_3613_TradingSession: '%s' "     ,         pack_stack.fast.fast_3613.seq[i].TradingSession        );
        $write("fast_3613_SecurityStatistics: '%s' " ,         pack_stack.fast.fast_3613.seq[i].SecurityStatistics    );
        $display();
    end
endfunction

`endif

