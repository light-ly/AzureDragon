module decode
    import config_pkg::core_cfg;
    import core_pkg::*;
(
    input  logic        clk,
    input  logic        rst,
    input  logic [63:0] inst_i,
    output logic        wen,
    output logic        imm_sel,
    output logic [63:0] imm,
    output logic [ 3:0] raddr1,
    output logic [ 3:0] raddr2,
    output logic [ 3:0] waddr
);

    typedef enum logic [2:0] {
        rtype,
        itype,
        stype,
        btype,
        utype,
        jtype,
        err_type
    } inst_type_e;

    core_pkg::instruction_t inst;

    // imm signal
    logic [core_cfg.XLEN-1:0] imm_i;
    logic [core_cfg.XLEN-1:0] imm_s;
    logic [core_cfg.XLEN-1:0] imm_b;
    logic [core_cfg.XLEN-1:0] imm_u;
    logic [core_cfg.XLEN-1:0] imm_j;

    // get inst info
    assign inst = inst_i;

    // generate imm
    assign imm_i = {{core_cfg.XLEN - 12{inst[31]}}, inst[31:20]};
    assign imm_s = {{core_cfg.XLEN - 12{inst[31]}}, inst[31:25], inst[11:7]};
    assign imm_b = {
        {core_cfg.XLEN - 13{inst[31]}},
        inst[31],
        inst[7],
        inst[30:25],
        inst[11:8],
        1'b0
    };
    assign imm_u = {{core_cfg.XLEN - 32{inst[31]}}, inst[31:12], 12'b0};
    assign imm_j = {
        {core_cfg.XLEN - 20{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0
    };

    // decode inst
    assign inst_type = (inst.rtype.opcode == core_pkg::OpcodeOpImm) ? itype : err_type;

    // gen ctrl signal
    assign raddr1 = inst.rtype.rs1;
    assign raddr2 = inst.rtype.rs2;

    assign wen   = (inst_type == itype) | (inst_type == jtype) | (inst_type == utype);
    assign waddr = inst.rtype.rd;

    assign imm_sel = (inst_type == itype) | (inst_type == stype) | (inst_type == btype) | (inst_type == jtype) | (inst_type == utype);
    assign imm     = ((inst_type == itype) & imm_i)
                   | ((inst_type == stype) & imm_s)
                   | ((inst_type == btype) & imm_b)
                   | ((inst_type == utype) & imm_u)
                   | ((inst_type == jtype) & imm_j);

endmodule  //Decode
