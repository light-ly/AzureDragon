module regfile
    import config_pkg::core_cfg;
#(
    parameter int unsigned ADDR_WIDTH = core_cfg.REG_ADDR_WIDTH,
    parameter logic [63:0] DATA_WIDTH = core_cfg.XLEN
) (
    input  logic                  clk,
    input  logic [ADDR_WIDTH-1:0] raddr1,
    input  logic [ADDR_WIDTH-1:0] raddr2,
    input  logic [DATA_WIDTH-1:0] wdata,
    input  logic [ADDR_WIDTH-1:0] waddr,
    input  logic                  wen,
    output logic [DATA_WIDTH-1:0] rdata1,
    output logic [DATA_WIDTH-1:0] rdata2
);

    logic [DATA_WIDTH-1:0] rdata1_reg;
    logic [DATA_WIDTH-1:0] rdata2_reg;
    logic [DATA_WIDTH-1:0] rf[2**ADDR_WIDTH-1:0];

    always_ff @(posedge clk) begin : wirte_port
        if (wen) begin
            rf[waddr] <= wdata;
        end else begin
            rf[waddr] <= rf[waddr];
        end
    end

    always_ff @(posedge clk) begin : read_port_1
        if (raddr1 == 0) begin
            rdata1_reg <= 0;
        end else begin
            rdata1_reg <= rf[raddr1];
        end
    end

    always_ff @(posedge clk) begin : read_port_2
        if (raddr2 == 0) begin
            rdata2_reg <= 0;
        end else begin
            rdata2_reg <= rf[raddr2];
        end
    end

    assign rdata1 = rdata1_reg;
    assign rdata2 = rdata2_reg;

endmodule
