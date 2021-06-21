package test_type;

typedef struct {
    int rate               ;
    int count_packets      ;
    string len_packet_type ;
    int len_packet_start   ;
    int len_packet_finish  ;
} gen_param_t;


typedef struct {
    reg [63:0] preambule;
    reg [47:0] mac_src;
    reg [47:0] mac_dst;
    reg [15:0] tp;
} ethernet_t;
typedef struct {
    reg [11:0] id;
    reg [15:0] tp;
} vlan_t;
typedef struct {
    reg [7:0] proto;
    reg [31:0] src;
    reg [31:0] dst;
} ip_t;
typedef struct {
    reg [15:0] src;
    reg [15:0] dst;
} udp_t;
typedef struct {
    reg [31:0] MDUpdateAction          ;//uInt32
    string     MDEntryType             ;//string
    string     MDEntryID               ;//string
    string     Symbol                  ;//string
    reg [31:0] RptSeq                  ;//Int32
    reg [31:0] TotalNumOfTrades        ;//Int32
    reg [31:0] TradeValue_exp          ;//Int32
    reg [63:0] TradeValue_man          ;//Int64
    reg [31:0] OfferNbOr               ;//Int32
    reg [31:0] BidNbOr                 ;//Int32
    reg [31:0] MDEntryPx_exp           ;//Int32
    reg [63:0] MDEntryPx_man           ;//Int64
    reg [31:0] MDEntrySize_exp         ;//Int32
    reg [63:0] MDEntrySize_man         ;//Int64
    reg [31:0] MDEntryDate             ;//uInt32
    reg [31:0] MDEntryTime             ;//uInt32
    reg [31:0] StartTime               ;//uInt32
    string     QuoteCondition          ;//string
    string     TradeCondition          ;//string
    string     OpenCloseSettlFlag      ;//string
    reg [31:0] NetChgPrevDay_exp       ;//Int32
    reg [63:0] NetChgPrevDay_man       ;//Int64
    reg [31:0] ChgFromWAPrice_exp      ;//Int32
    reg [63:0] ChgFromWAPrice_man      ;//Int64
    reg [31:0] ChgOpenInterest_exp     ;//Int32
    reg [63:0] ChgOpenInterest_man     ;//Int64
    reg [31:0] BidMarketSize_exp       ;//Int32
    reg [63:0] BidMarketSize_man       ;//Int64
    reg [31:0] AskMarketSize_exp       ;//Int32
    reg [63:0] AskMarketSize_man       ;//Int64
    reg [31:0] ChgFromSettlmnt_exp     ;//Int32
    reg [63:0] ChgFromSettlmnt_man     ;//Int64
    reg [31:0] SettlDate               ;//uInt32
    reg [31:0] SettlDate2              ;//uInt32
    string     SettleType              ;//string
    string     CXFlag                  ;//string
    string     TradingSessionID        ;//string
    string     TradingSessionSubID     ;//string
    string     TradingSession          ;//string
    string     SecurityStatistics      ;//string
} fast_3613_seq_t;                          
typedef struct {
    reg [31:0] MsgSeqNum       ;//uInt32
    reg [63:0] SendingTime     ;//uInt64
    reg [63:0] LastUpdateTime  ;//uInt64
    reg [31:0] NoMDEntries     ;//uInt32
    fast_3613_seq_t seq[]      ;  
} fast_3613_t;                          

typedef struct {
    reg [31:0] preambule;
    reg [31:0] pmap;
    reg [31:0] id;
    fast_3613_t fast_3613;
} fast_t;

typedef struct {
    ethernet_t ethernet;
    vlan_t     vlan;
    ip_t       ip;
    udp_t      udp;
    fast_t     fast;
} pack_stack_t;

endpackage

