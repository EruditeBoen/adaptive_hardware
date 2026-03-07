.PHONY: all

regress:
        iverilog -o build/sim rtl/branch_predictors.v tb/tb_predictor.v
        vvp build/sim

visual:
        gtkwave wave.vcd
