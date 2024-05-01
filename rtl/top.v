module top(
        input clk,
        input rst,
        input  [63:0] src1,
        input  [63:0] src2,
        output [63:0] out
    );

    // outports wire
    wire [63:0] 	sum;
    wire [63:0] 	dout;

    adder u_adder(
            .src1 	( src1  ),
            .src2 	( src2  ),
            .sum  	( sum   )
        );

    Reg #(
            .DATA_WIDTH 	( 64 ),
            .RESET_VAL  	( 0  )
        ) u_Reg
        (
            .clk  	( clk   ),
            .rst  	( rst   ),
            .din  	( sum   ),
            .dout 	( dout  )
        );

    assign out = dout;

endmodule //top
