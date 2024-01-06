all: 	compile sim
# dont compile the trial.sv before compiling the design and the interface and the package 
# The order makes a difference 
# if u want to dont care about the the order of compilation check file trial_no_order.sv
compile:
		vlib work
		vlog -sv counter.sv intf.sv my_packages.sv  tb.sv   
compile_sequence_item:
		vlib work
		vlog -sv  sequence_item.sv
compile_sequencer:
		vlib work
		vlog -sv sequencer.sv
compile_driver:
		vlib work
		vlog -sv driver.sv 
compile_monitor:
		vlib work
		vlog -sv monitor.sv 
compile_scoreboard:
		vlib work
		vlog -sv scoreboard.sv
sim:
		vsim -logfile sim.log -c -do "run -all" work.tb

wave:
		vsim work.trial -voptargs=+acc
