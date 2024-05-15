module reg_temp #(
    parameter int unsigned DATA_WIDTH = 1,
    parameter logic [DATA_WIDTH-1:0] RESET_VAL = 0
) (
    input  logic                      clk,
    input  logic                      rst,
    input  logic [DATA_WIDTH - 1 : 0] din,
    output logic [DATA_WIDTH - 1 : 0] dout
);

    logic sys_rst;
    logic sys_rst_r;
    logic [DATA_WIDTH - 1:0] dout_r;

    always_ff @(posedge clk or posedge rst) begin : async
        if (rst) begin
            sys_rst   <= 1'b1;
            sys_rst_r <= 1'b1;
        end else begin
            sys_rst   <= 1'b0;
            sys_rst_r <= sys_rst_r;
        end
    end

    always_ff @(posedge clk or posedge sys_rst) begin : sync
        if (sys_rst) begin
            dout_r <= RESET_VAL;
        end else begin
            dout_r <= din;
        end
    end

    assign dout = dout_r;

endmodule  //Reg with Synchronized Asynchronous Reset
