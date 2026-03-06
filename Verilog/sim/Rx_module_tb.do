
vlog ../src/Rx_module.v
vlog ../src/Rx_module_tb.v

vsim Rx_module_tb

add wave -group my_first_group Rx_module_tb/*
add wave -group UUT Rx_module_tb/DUT/*

config wave -signalnamewidth 1
radix binary

restart -f
run 300ns


