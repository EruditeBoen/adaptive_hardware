module predictor (
    input wire clk,
    input wire rst_n,
    input wire x,       // current observed bit
    output wire pred    // prediction for next bit
);

    // Internal learning rate (observable in simulation)
    reg [1:0] ctr;

    // Combinational predition from current state
    // ctr = 2,3 -> predict 1
    // ctr = 0,1 -> predict 0
    assign pred = ctr[1];

    // Sequential learning rule
    always @(posedge clk) begin
        if (!rst_n) begin
            // Weakly biased initial state (design choice)
            ctr <= 2'b01;
        end else begin
            if (x) begin
                // Increment toward strongly-1
                if (ctr != 2'b11)
                    ctr <= ctr + 1'b1;
            end else begin
                // Decrement toward strongly-0
                if (ctr != 2'b00)
                    ctr <= ctr - 1'b1;
            end
        end
    end
endmodule