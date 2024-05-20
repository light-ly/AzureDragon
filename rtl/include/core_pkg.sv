package core_pkg;

    import config_pkg::core_cfg;

    typedef struct packed {
        logic [31:25] func7;
        logic [24:20] rs2;
        logic [19:15] rs1;
        logic [14:12] func3;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } rtype_t;

    typedef struct packed {
        logic [31:20] imm;
        logic [19:15] rs1;
        logic [14:12] func3;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } itype_t;

    typedef struct packed {
        logic [31:25] imm;
        logic [24:20] rs2;
        logic [19:15] rs1;
        logic [14:12] funct3;
        logic [11:7]  imm0;
        logic [6:0]   opcode;
    } stype_t;

    typedef struct packed {
        logic [31:12] imm;
        logic [11:7]  rd;
        logic [6:0]   opcode;
    } utype_t;

    typedef union packed {
        logic [31:0] instr;
        rtype_t      rtype;
        itype_t      itype;
        stype_t      stype;
        utype_t      utype;
    } instruction_t;

    // opcode defination: RV32/64G
    // 00
    localparam logic [7:0] OpcodeLoad = 7'b00_000_11;
    localparam logic [7:0] OpcodeLoadFp = 7'b00_001_11;
    localparam logic [7:0] OpcodeMiscMem = 7'b00_011_11;
    localparam logic [7:0] OpcodeOpImm = 7'b00_100_11;
    localparam logic [7:0] OpcodeAuipc = 7'b00_101_11;
    localparam logic [7:0] OpcodeOpImm32 = 7'b00_110_11;
    // 01
    localparam logic [7:0] OpcodeStore = 7'b01_000_11;
    localparam logic [7:0] OpcodeStoreFp = 7'b01_001_11;
    localparam logic [7:0] OpcodeAmo = 7'b01_011_11;
    localparam logic [7:0] OpcodeOp = 7'b01_100_11;
    localparam logic [7:0] OpcodeLui = 7'b01_101_11;
    localparam logic [7:0] OpcodeOp32 = 7'b01_011_11;
    // 10
    localparam logic [7:0] OpcodeMadd = 7'b10_000_11;
    localparam logic [7:0] OpcodeMsub = 7'b10_001_11;
    localparam logic [7:0] OpcodeNmsub = 7'b10_010_11;
    localparam logic [7:0] OpcodeNmadd = 7'b10_011_11;
    localparam logic [7:0] OpcodeOpFp = 7'b10_100_11;
    // 11
    localparam logic [7:0] OpcodeBranch = 7'b11_000_11;
    localparam logic [7:0] OpcodeJalr = 7'b11_001_11;
    localparam logic [7:0] OpcodeJal = 7'b11_011_11;
    localparam logic [7:0] OpcodeSystem = 7'b11_100_11;

endpackage
