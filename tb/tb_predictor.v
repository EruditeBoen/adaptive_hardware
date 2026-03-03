`timescale 1ns/1ps

module tb_predictor;

    // Clock and reset
    reg clk = 0;
    reg rst_n = 0;

    // Input stream
    reg x;

    // DUT output
    wire pred;

    // Observer-only signals
    reg pred_prev;
    reg correct;

    // Instantiate DUT
    predictor dut (
        .clk  (clk),
        .rst_n(rst_n),
        .x    (x),
        .pred (pred)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Save prediction and compute correctness
    always @(posedge clk) begin
        pred_prev <= pred;
        correct   <= (pred_prev == x);
    end

    // Stimulus
    initial begin
        // Waveform dump
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_predictor);

        // Initial conditions
        x = 0;

        // Apply reset for a few cycles
        #12;
        rst_n = 1;

        // -------- Test 1: steady 1s --------
        repeat (10) begin
            @(posedge clk);
            x <= 1'b1;
        end

        // -------- Test 2: steady 0s --------
        repeat (10) begin
            @(posedge clk);
            x <= 1'b0;
        end

        // -------- Test 3: alternating --------
        repeat (10) begin
            @(posedge clk);
            x <= ~x;
        end

        // Finish
        #20;
        $finish;
    end

endmodule


