module div5_50 (
    input  logic clk,
    input  logic rst_n,
    output logic clk_div5
);

logic [2:0] cnt_p, cnt_n;
logic clk_p, clk_n;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_p <= 0;
        clk_p <= 0;
    end
    else begin
        cnt_p <= (cnt_p == 4) ? 0 : cnt_p + 1;
        if (cnt_p == 0)
            clk_p <= 1;
        else if (cnt_p == 2)
            clk_p <= 0;
    end
end

always_ff @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt_n <= 0;
        clk_n <= 0;
    end
    else begin
        cnt_n <= (cnt_n == 4) ? 0 : cnt_n + 1;
        if (cnt_n == 0)
            clk_n <= 1;
        else if (cnt_n == 2)
            clk_n <= 0;
    end
end

assign clk_div5 = clk_p | clk_n;

property p_div5_toggle;
  @(posedge clk) disable iff (!rst_n)
    $changed(clk_div5) |-> ##5 $changed(clk_div5);
endproperty

assert property (p_div5_toggle);

endmodule
