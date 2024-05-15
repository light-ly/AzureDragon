module ram
    import config_pkg::core_cfg;
#(
    parameter int unsigned ADDR_WIDTH = core_cfg.REG_ADDR_WIDTH,
    parameter logic [63:0] DATA_WIDTH = core_cfg.XLEN
) (
    input                   clk,
    input  [ADDR_WIDTH-1:0] addr,
    output [DATA_WIDTH-1:0] data
);

    logic [DATA_WIDTH-1:0] sram[2**ADDR_WIDTH-1:0];

    assign data = sram[addr];

    regfile #(
        .ADDR_WIDTH(core_cfg.REG_ADDR_WIDTH),
        .DATA_WIDTH(core_cfg.XLEN)
    ) regfile (
        .clk   (clk),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .wdata (wdata),
        .waddr (waddr),
        .wen   (wen),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

endmodule  //ram
