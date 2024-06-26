module alu (
    input  logic [63:0] src1,
    input  logic [63:0] src2,
    input  logic [63:0] imm,
    input  logic        imm_sel,
    output logic [63:0] alu_result
);

    logic [63:0] real_src2;
    logic [63:0] sum;

    assign real_src2 = imm_sel ? imm : src2;
    assign sum = src1 + real_src2;

    assign alu_result = sum;

endmodule  //add
