module pc
    import config_pkg::core_cfg;
(
    input  logic        clk,
    input  logic        rst,
    input  logic [63:0] next_pc,
    output logic [63:0] pc
);

    reg_temp #(
        .DATA_WIDTH(core_cfg.XLEN),
        .RESET_VAL (core_cfg.RESET_VECTOR)
    ) pc_reg (
        .clk (clk),
        .rst (rst),
        .din (next_pc),
        .dout(pc)
    );

endmodule  //PC
