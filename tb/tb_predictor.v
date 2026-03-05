`timescale 1ns/1ps

module tb_predictor;

    // Clock and Reset
    reg clk = 0;
    reg rst_n = 0;

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Stimulus and Predictions
    reg x;

    wire adaptive_pred;
    reg static_pred;
    reg last_pred;

    reg last_value;

    // Instantiate DUT
    predictor dut (
        .clk  (clk),
        .rst_n(rst_n),
        .x    (x),
        .pred (adaptive_pred)
    );

    // Accuracy Counters

    integer cycle;

    integer correct_adaptive;
    integer correct_static;
    integer correct_last;

    real adaptive_acc;
    real static_acc;
    real last_acc;

    // Logging
    integer log_file;

    // Predictors

    always @(posedge clk) begin
        static_pred <= 1'b0;
        last_pred   <= last_value;
        last_value  <= x;
    end


    // Save prediction and compute correctness
    task count_cycle;
    begin
        cycle = cycle + 1;

        if (adaptive_pred == x)
            correct_adaptive = correct_adaptive + 1;

        if (static_pred == x)
            correct_static = correct_static + 1;

        if (last_pred == x)
            correct_last = correct_last + 1;
    end
    endtask

    // Stimulus
    task reset_metrics;
    begin
        cycle            = 0;

        correct_adaptive = 0;
        correct_static   = 0;
        correct_last     = 0;

        last_value       = 0;
    end
    endtask

    task compute_accuracy;
    begin
        adaptive_acc = correct_adaptive * 1.0 / cycle;
        static_acc   = correct_static   * 1.0 / cycle;
        last_acc     = correct_last     * 1.0 / cycle;
    end
    endtask
    
    task log_results;
        input [127:0] name;
    begin
        $fdisplay(log_file,
                  "%s,%.4f,%.4f,%.4f",
                  name,
                  adaptive_acc,
                  static_acc,
                  last_acc);
    end
    endtask

    // Workloads
    task run_stationary;
        input integer seed;
        integer rand_val;
    begin
        // -------- Test 1: Stationary Biased --------
        reset_metrics();

        repeat (500) begin
            @(posedge clk);

            rand_val = $random;
            if (rand_val < 0)
                rand_val = -rand_val;

            rand_val = rand_val % 100;

            x <= (rand_val < 80) ? 0 : 1;
            count_cycle();
        end

        compute_accuracy();
        log_results("Stationary");

    end
    endtask

    task run_regime_shift;
        input integer seed;
        integer rand_val;
    begin

        // -------- Test 2: Regime Shift --------
        reset_metrics();

        repeat (500) begin
            @(posedge clk);
            rand_val = $random;
            if (rand_val < 0)
                rand_val = -rand_val;

            rand_val = rand_val % 100;

            x <= (rand_val < 80) ? 0 : 1;
            count_cycle();
        end

        repeat (500) begin
            @(posedge clk);
            rand_val = $random;
            if (rand_val < 0)
                rand_val = -rand_val;

            rand_val = rand_val % 100;

            x <= (rand_val < 80) ? 1 : 0;
            count_cycle();
        end

        compute_accuracy();
        log_results("RegimeShift");

    end
    endtask

    task run_oscillatory;
    begin

        // // -------- Test 3: Oscillatory --------
        reset_metrics();

        repeat (50) begin
            repeat (5) begin
                @(posedge clk);
                x <= 1'b0;
                count_cycle();
            end
            repeat (5) begin
                @(posedge clk);
                x <= 1'b1;
                count_cycle();
            end
        end

        compute_accuracy();
        log_results("Oscillatory");

    end
    endtask

    // Main Simulation
    initial begin

        // Waveform dump
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_predictor);

        log_file = $fopen("../results/summary.csv", "w");
        $fdisplay(log_file, "Workload,Adaptive,Static,LastValue");

        rst_n = 0;
        repeat(5) @(posedge clk);
        rst_n = 1;

        // Run workloads
        run_stationary(1);
        run_regime_shift(1);
        run_oscillatory();

        $fclose(log_file);
        $display("Simulation complete.");

        #20;
        $finish;
        
    end

endmodule
