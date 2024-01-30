module top(
    input clk_i,
    output[1:0] led
);
    wire clk;
    BUFGCTRL bufg_i (
        .I0(clk_i),
        .CE0(1'b1),
        .S0(1'b1),
        .O(clk)
    );
    
    reg clkdiv;
    reg [22:0] cntr;

    always @(posedge clk) {clkdiv, cntr} <= cntr + 1'b1;

    assign led[0] = clkdiv;
    assign led[1] = 1'b1;

endmodule