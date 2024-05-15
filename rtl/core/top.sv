module top (
    input logic clk,
    input logic rst
);

    logic [63:0] pc;
    logic [63:0] next_pc;
    logic [63:0] inst;
    logic [63:0] next_inst;
    logic        wen;
    logic        en_imm;
    logic [63:0] imm;
    logic [ 3:0] raddr1;
    logic [ 3:0] raddr2;
    logic [ 3:0] waddr;
    logic [63:0] alu_result;

    pc u_PC (
        .clk    (clk),
        .rst    (rst),
        .next_pc(next_pc),
        .pc     (pc)
    );

    inst_fetch u_InstFetch (
        .clk      (clk),
        .rst      (rst),
        .next_inst(next_inst),
        .inst     (inst)
    );

    ram #(
        .ADDR_WIDTH(5),
        .DATA_WIDTH(64)
    ) u_ram (
        .clk (clk),
        .addr(pc),
        .data(next_inst)
    );

    decode u_Decode (
        .clk   (clk),
        .rst   (rst),
        .inst  (inst),
        .wen   (wen),
        .en_imm(en_imm),
        .imm   (imm),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr (waddr)
    );

    regfile #(
        .ADDR_WIDTH(5),
        .DATA_WIDTH(64)
    ) u_reg (
        .clk   (clk),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .wdata (alu_result),
        .waddr (waddr),
        .wen   (wen),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    alu u_alu (
        .src1      (rdata1),
        .src2      (rdata2),
        .imm       (imm),
        .en_imm    (en_imm),
        .alu_result(alu_result)
    );

    assign next_pc = pc + 4;

endmodule  //top
