package config_pkg;

    typedef struct packed {
        int unsigned XLEN;
        int unsigned REG_ADDR_WIDTH;
        logic [31:0] RESET_VECTOR;
    } core_cfg_t;

    localparam core_cfg_t core_cfg = '{
        XLEN: unsigned'(64),
        REG_ADDR_WIDTH: unsigned'(5),
        RESET_VECTOR: 32'h80000000
    };

endpackage
