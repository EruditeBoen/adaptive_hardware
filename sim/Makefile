.PHONY: all

sim:
	iverilog -o sim ../rtl/branch_predictors.v ../tb/tb_predictor.v
	vvp sim
	gtkwave wave.vcd

run:
	iverilog -o sim ../rtl/branch_predictors.v ../tb/tb_predictor.v
	vvp sim

visual:
	gtkwave wave.vcd

