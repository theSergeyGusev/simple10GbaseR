package gtype;

    typedef struct packed {
        logic        ena;   
        logic [3:0]  ctrl;   
        logic [31:0] data;   
    } xgmii32_t; 

    typedef struct packed {
        logic        ena;   
        logic [7:0]  ctrl;   
        logic [63:0] data;   
    } xgmii64_t; 

endpackage
