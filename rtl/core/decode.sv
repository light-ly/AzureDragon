module decode (
    input  logic        clk,
    input  logic        rst,
    input  logic [63:0] inst,
    output logic        wen,
    output logic        en_imm,
    output logic [63:0] imm,
    output logic [ 3:0] raddr1,
    output logic [ 3:0] raddr2,
    output logic [ 3:0] waddr
);

    localparam logic [6:0] OP_IMM = 7'b0010011;

    localparam logic [2:0] TYPE_R = 3'b000;
    localparam logic [2:0] TYPE_I = 3'b001;
    localparam logic [2:0] TYPE_S = 3'b010;
    localparam logic [2:0] TYPE_B = 3'b011;
    localparam logic [2:0] TYPE_U = 3'b100;
    localparam logic [2:0] TYPE_J = 3'b101;
    localparam logic [2:0] TYPE_N = 3'b110;

    // inst split signal
    logic [ 6:0] opcode;
    logic [ 4:0] rd;
    logic [ 2:0] funct3;
    logic [ 4:0] rs1;
    logic [ 4:0] rs2;
    logic [ 6:0] funct7;
    logic [63:0] imm_I;
    logic [63:0] imm_S;
    logic [63:0] imm_B;
    logic [63:0] imm_U;
    logic [63:0] imm_J;

    // inst decode signal
    logic [ 2:0] inst_type;

    // split inst
    assign opcode = inst[6:0];
    assign rd = inst[11:7];
    assign funct3 = inst[14:12];
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign funct7 = inst[31:25];
    assign imm_I = {{20{inst[31]}}, inst[31:20]};
    assign imm_S = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    assign imm_B = {
        {19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0
    };
    assign imm_U = {inst[31:12], 12'b0};
    assign imm_J = {
        {11{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0
    };

    // decode inst
    assign inst_type = (opcode == OP_IMM) ? TYPE_I : TYPE_N;

    // gen ctrl signal
    assign raddr1 = rs1;
    assign raddr2 = rs2;
    assign wen    = (inst_type == TYPE_I) | (inst_type == TYPE_J) | (inst_type == TYPE_U);
    assign waddr = rd;
    assign en_imm = (inst_type == TYPE_I) | (inst_type == TYPE_S) | (inst_type == TYPE_B) | (inst_type == TYPE_J) | (inst_type == TYPE_U);
    assign imm    = ((inst_type == TYPE_I) & imm_I)
                  | ((inst_type == TYPE_S) & imm_S)
                  | ((inst_type == TYPE_B) & imm_B)
                  | ((inst_type == TYPE_U) & imm_U)
                  | ((inst_type == TYPE_J) & imm_J);

endmodule  //Decode
