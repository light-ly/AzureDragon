module inst_fetch (
    input  logic        clk,
    input  logic        rst,
    input  logic [63:0] next_inst,
    output logic [63:0] inst
);

    reg_temp #(
        .DATA_WIDTH(63),
        .RESET_VAL (0)
    ) u_Reg (
        .clk (clk),
        .rst (rst),
        .din (next_inst),
        .dout(inst)
    );

endmodule  //InstFetch
