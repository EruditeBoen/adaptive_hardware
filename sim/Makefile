.PHONY: all

sim:
	iverilog -o sim ../rtl/predictor.v ../tb/tb_predictor.v
	vvp sim
	gtkwave wave.vcd

compile:
	iverilog -o sim ../rtl/predictor.v ../tb/tb_predictor.v

run:
	vvp sim

visual:
	gtkwave wave.vcd

