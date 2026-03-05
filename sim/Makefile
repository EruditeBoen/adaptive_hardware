.PHONY: all

sim:
	iverilog -o sim ../rtl/branch_predictors.v ../tb/tb_predictor.v
	vvp sim
	gtkwave wave.vcd

compile:
	iverilog -o sim ../rtl/branch_predictors.v ../tb/tb_predictor.v

run:
	vvp sim

visual:
	gtkwave wave.vcd

